import { Controller, Get, Put, Body, Inject } from "@nestjs/common";
import { ApiTags, ApiOperation } from "@nestjs/swagger";
import { AccountService } from "./account.service";

@ApiTags("account")
@Controller("account")
export class AccountController {
  constructor(
    @Inject("DB") private readonly db: any,
    private readonly accountService: AccountService
  ) {}

  @Get("profile")
  @ApiOperation({ summary: "Get user profile" })
  async getProfile() {
    return this.accountService.getProfile();
  }

  @Put("profile")
  @ApiOperation({ summary: "Update user profile" })
  async updateProfile(@Body() data: any) {
    return this.accountService.updateProfile(data);
  }
}

