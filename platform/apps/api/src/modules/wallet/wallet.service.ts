import { Injectable, Inject } from "@nestjs/common";

@Injectable()
export class WalletService {
  constructor(@Inject("DB") private readonly db: any) {}

  async getBalance() {
    return { balance: 0, pending: 0, total: 0 };
  }

  async getTransactions() {
    return { data: [] };
  }
}

