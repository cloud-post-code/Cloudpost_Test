import { Injectable, Inject } from "@nestjs/common";

@Injectable()
export class AccountService {
  constructor(@Inject("DB") private readonly db: any) {}

  async getProfile() {
    return { name: "User", email: "user@example.com" };
  }

  async updateProfile(data: any) {
    return { ...data };
  }
}

