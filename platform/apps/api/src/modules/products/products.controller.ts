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
    // TODO: Get userId from authenticated user session/token
    // For now, using a placeholder userId = 1
    const userId = query.userId || 1;
    return this.productsService.getProducts(query, userId);
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

  @Get("options")
  @ApiOperation({ summary: "Get product options" })
  async getProductOptions(@Query() query: any) {
    // TODO: Get userId from authenticated user session/token
    // For now, using a placeholder userId = 1
    const userId = query.userId || 1;
    return this.productsService.getProductOptions(userId);
  }

  @Post("options")
  @ApiOperation({ summary: "Create product option" })
  async createProductOption(@Body() data: any) {
    // TODO: Get userId from authenticated user session/token
    // For now, using a placeholder userId = 1
    const userId = data.userId || 1;
    return this.productsService.createProductOption(userId, data);
  }

  @Post("options/values")
  @ApiOperation({ summary: "Create option value" })
  async createOptionValue(@Body() data: any) {
    return this.productsService.createOptionValue(data);
  }

  @Put(":id/tags")
  @ApiOperation({ summary: "Add or update tags for a product" })
  async updateProductTags(@Param("id") id: string, @Body() data: { tags: string[] }) {
    return this.productsService.addTagsToProduct(parseInt(id), data.tags || []);
  }

  @Put(":id/activate")
  @ApiOperation({ summary: "Activate a product" })
  async activateProduct(@Param("id") id: string) {
    return this.productsService.activateProduct(parseInt(id));
  }

  @Put(":id/deactivate")
  @ApiOperation({ summary: "Deactivate a product" })
  async deactivateProduct(@Param("id") id: string) {
    return this.productsService.deactivateProduct(parseInt(id));
  }

  @Post("bulk-activate")
  @ApiOperation({ summary: "Activate multiple products" })
  async bulkActivateProducts(@Body() data: { productIds: number[] }) {
    return this.productsService.bulkActivateProducts(data.productIds);
  }

  @Post("bulk-deactivate")
  @ApiOperation({ summary: "Deactivate multiple products" })
  async bulkDeactivateProducts(@Body() data: { productIds: number[] }) {
    return this.productsService.bulkDeactivateProducts(data.productIds);
  }

  @Post("bulk-delete")
  @ApiOperation({ summary: "Delete multiple products" })
  async bulkDeleteProducts(@Body() data: { productIds: number[] }) {
    return this.productsService.bulkDeleteProducts(data.productIds);
  }

  @Get(":id/clone")
  @ApiOperation({ summary: "Get product data for cloning" })
  async getProductForClone(@Param("id") id: string) {
    return this.productsService.getProductForClone(parseInt(id));
  }

  @Get("occasions")
  @ApiOperation({ summary: "Get distinct occasions from products" })
  async getOccasions() {
    return this.productsService.getOccasions();
  }

  @Get("categories")
  @ApiOperation({ summary: "Get product categories" })
  async getProductCategories(@Query() query: any) {
    const langId = query.langId || 1;
    return this.productsService.getProductCategories(langId);
  }
}

