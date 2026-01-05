import { Controller, Get, Post, Inject } from "@nestjs/common";
import { ApiTags, ApiOperation } from "@nestjs/swagger";
import { WalletService } from "./wallet.service";

@ApiTags("wallet")
@Controller("wallet")
export class WalletController {
  constructor(
    @Inject("DB") private readonly db: any,
    private readonly walletService: WalletService
  ) {}

  @Get("balance")
  @ApiOperation({ summary: "Get wallet balance" })
  async getBalance() {
    return this.walletService.getBalance();
  }

  @Get("transactions")
  @ApiOperation({ summary: "Get transaction history" })
  async getTransactions() {
    return this.walletService.getTransactions();
  }
}

