import { Controller, Get, Put, Body, Query, UsePipes, ValidationPipe } from "@nestjs/common";
import { ApiTags, ApiOperation, ApiQuery } from "@nestjs/swagger";
import { ShopService } from "./shop.service";
import { UpdateShopDto } from "./dto/update-shop.dto";

@ApiTags("shop")
@Controller("shop")
export class ShopController {
  constructor(private readonly shopService: ShopService) {}

  @Get()
  @ApiOperation({ summary: "Get shop settings" })
  @ApiQuery({ name: "langId", required: false, type: Number, description: "Language ID" })
  async getShop(@Query("langId") langId?: number) {
    // TODO: Get userId from authenticated user session/token
    // For now, using a placeholder userId = 1
    const userId = 1;
    const languageId = langId ? Number(langId) : 1;
    return this.shopService.getShop(userId, languageId);
  }

  @Put()
  @ApiOperation({ summary: "Update shop settings" })
  @UsePipes(new ValidationPipe({ whitelist: true, transform: true }))
  async updateShop(@Body() data: UpdateShopDto, @Query("langId") langId?: number) {
    // TODO: Get userId from authenticated user session/token
    // For now, using a placeholder userId = 1
    const userId = 1;
    const languageId = langId ? Number(langId) : 1;
    return this.shopService.updateShop(userId, data, languageId);
  }
}

