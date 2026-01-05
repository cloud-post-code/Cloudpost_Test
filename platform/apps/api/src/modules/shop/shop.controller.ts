import { Controller, Get, Post, Put, Body, Param, Inject } from "@nestjs/common";
import { ApiTags, ApiOperation } from "@nestjs/swagger";
import { ShopService } from "./shop.service";

@ApiTags("shop")
@Controller("shop")
export class ShopController {
  constructor(
    @Inject("DB") private readonly db: any,
    private readonly shopService: ShopService
  ) {}

  @Get()
  @ApiOperation({ summary: "Get shop settings" })
  async getShop() {
    return this.shopService.getShop();
  }

  @Put()
  @ApiOperation({ summary: "Update shop settings" })
  async updateShop(@Body() data: any) {
    return this.shopService.updateShop(data);
  }
}

