import { Injectable, UnauthorizedException, ConflictException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { UsersService } from '../users/users.service';
import { AdminService } from '../admin/admin.service';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private adminService: AdminService,
    private jwtService: JwtService,
  ) {}

  async validateUser(email: string, password: string): Promise<any> {
    const user = await this.usersService.findByEmail(email);
    if (user && user.active && (await bcrypt.compare(password, user.password))) {
      const { password: _, ...result } = user;
      return result;
    }
    return null;
  }

  async validateAdmin(username: string, password: string): Promise<any> {
    const admin = await this.adminService.findByUsername(username);
    if (admin && admin.adminActive && (await this.adminService.validatePassword(admin, password))) {
      const { adminPassword: _, adminPasswordOld: __, ...result } = admin;
      return result;
    }
    return null;
  }

  async register(userData: {
    email: string;
    username: string;
    password: string;
    name: string;
    phone?: string;
    phoneDcode?: string;
  }) {
    // Check if user already exists
    const existingUser = await this.usersService.findByEmail(userData.email);
    if (existingUser) {
      throw new ConflictException('User with this email already exists');
    }

    // Create new user
    const user = await this.usersService.create(userData);
    const { password: _, ...userWithoutPassword } = user as any;
    return userWithoutPassword;
  }

  async login(user: any) {
    const payload = {
      email: user.email || user.credentialEmail,
      sub: user.userId || user.id,
      role: 'user',
    };
    return {
      access_token: this.jwtService.sign(payload),
      user: {
        id: user.userId || user.id,
        email: user.email || user.credentialEmail,
        name: user.userName || user.name,
        isBuyer: user.userIsBuyer,
        isSupplier: user.userIsSupplier,
      },
    };
  }

  async loginAdmin(admin: any) {
    const payload = {
      username: admin.adminUsername,
      sub: admin.adminId,
      role: 'admin',
    };
    return {
      access_token: this.jwtService.sign(payload),
      admin: {
        id: admin.adminId,
        username: admin.adminUsername,
        email: admin.adminEmail,
        name: admin.adminName,
      },
    };
  }
}

