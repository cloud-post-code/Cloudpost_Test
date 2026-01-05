import { Controller, Get, Post, Put, Delete, Body, Param, Query, Inject } from "@nestjs/common";
import { ApiTags, ApiOperation } from "@nestjs/swagger";
import { ProductsService } from "./products.service";

@ApiTags("products")
@Controller("products")
export class ProductsController {
  constructor(
    @Inject("DB") private readonly db: any,
    private readonly productsService: ProductsService
  ) {}

  @Get()
  @ApiOperation({ summary: "Get products list" })
  async getProducts(@Query() query: any) {
    return this.productsService.getProducts(query);
  }

  @Get(":id")
  @ApiOperation({ summary: "Get product by ID" })
  async getProduct(@Param("id") id: string) {
    return this.productsService.getProduct(parseInt(id));
  }

  @Post()
  @ApiOperation({ summary: "Create product" })
  async createProduct(@Body() data: any) {
    return this.productsService.createProduct(data);
  }

  @Put(":id")
  @ApiOperation({ summary: "Update product" })
  async updateProduct(@Param("id") id: string, @Body() data: any) {
    return this.productsService.updateProduct(parseInt(id), data);
  }

  @Delete(":id")
  @ApiOperation({ summary: "Delete product" })
  async deleteProduct(@Param("id") id: string) {
    return this.productsService.deleteProduct(parseInt(id));
  }
}

