import { Injectable, Inject } from "@nestjs/common";
import { shops, shopsLang } from "@cloudpost/database";

@Injectable()
export class ShopService {
  constructor(@Inject("DB") private readonly db: any) {}

  async getShop() {
    // TODO: Get shop by user ID from auth
    return { message: "Shop data" };
  }

  async updateShop(data: any) {
    // TODO: Update shop settings
    return { message: "Shop updated" };
  }
}

