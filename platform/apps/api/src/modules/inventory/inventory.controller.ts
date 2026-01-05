import { Controller, Get, Put, Body, Param, Inject } from "@nestjs/common";
import { ApiTags, ApiOperation } from "@nestjs/swagger";
import { InventoryService } from "./inventory.service";

@ApiTags("inventory")
@Controller("inventory")
export class InventoryController {
  constructor(
    @Inject("DB") private readonly db: any,
    private readonly inventoryService: InventoryService
  ) {}

  @Get()
  @ApiOperation({ summary: "Get inventory list" })
  async getInventory() {
    return this.inventoryService.getInventory();
  }

  @Put(":id")
  @ApiOperation({ summary: "Update inventory" })
  async updateInventory(@Param("id") id: string, @Body() data: any) {
    return this.inventoryService.updateInventory(parseInt(id), data);
  }
}

