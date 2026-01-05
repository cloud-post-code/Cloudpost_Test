import { Injectable, Inject } from "@nestjs/common";

@Injectable()
export class InventoryService {
  constructor(@Inject("DB") private readonly db: any) {}

  async getInventory() {
    return { data: [] };
  }

  async updateInventory(id: number, data: any) {
    return { id, ...data };
  }
}

