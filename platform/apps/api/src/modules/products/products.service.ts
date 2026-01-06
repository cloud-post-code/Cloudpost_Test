import { Injectable, Inject, NotFoundException } from "@nestjs/common";
import { eq, and, inArray } from "drizzle-orm";
import {
  productOptions,
  productOptionsLang,
  optionValues,
  optionValuesLang,
  products,
  productsLang,
  productToTags,
  tags,
  tagsLang,
  productToCategory,
  productCategories,
  productCategoriesLang,
  sellerProducts,
  sellerProductsLang,
} from "@cloudpost/database";

@Injectable()
export class ProductsService {
  constructor(@Inject("DB") private readonly db: any) {}

  async getProducts(query: any, userId?: number, langId: number = 1) {
    // TODO: Get userId from authenticated user session/token
    // For now, using a placeholder userId = 1
    const sellerId = userId || query.userId || 1;

    // Get all products for the seller
    const productList = await this.db
      .select()
      .from(products)
      .where(and(eq(products.sellerId, sellerId), eq(products.deleted, false)));

    // Get language-specific names and tags for each product
    const productsWithDetails = await Promise.all(
      productList.map(async (product) => {
        // Get product name in language
        const [productLang] = await this.db
          .select()
          .from(productsLang)
          .where(
            and(
              eq(productsLang.productId, product.id),
              eq(productsLang.langId, langId)
            )
          )
          .limit(1);

        // Get product tags
        const productTagRelations = await this.db
          .select()
          .from(productToTags)
          .where(eq(productToTags.productId, product.id));

        const tagIds = productTagRelations.map((rel) => rel.tagId);

        // Get tag details
        const productTags =
          tagIds.length > 0
            ? (
                await Promise.all(
                  tagIds.map(async (tagId) => {
                    const [tag] = await this.db
                      .select()
                      .from(tags)
                      .where(and(eq(tags.id, tagId), eq(tags.active, true)))
                      .limit(1);

                    if (!tag) return null;

                    const [tagLang] = await this.db
                      .select()
                      .from(tagsLang)
                      .where(
                        and(
                          eq(tagsLang.tagId, tag.id),
                          eq(tagsLang.langId, langId)
                        )
                      )
                      .limit(1);

                    return {
                      id: tag.id,
                      identifier: tag.identifier,
                      name: tagLang?.name || "",
                    };
                  })
                )
              ).filter((tag) => tag !== null)
            : [];

        // Get seller product data for price, stock, SKU
        const [sellerProduct] = await this.db
          .select()
          .from(sellerProducts)
          .where(eq(sellerProducts.productId, product.id))
          .limit(1);

        return {
          id: product.id,
          identifier: product.identifier,
          name: productLang?.name || "",
          active: product.active,
          featured: product.featured,
          sku: sellerProduct?.sku || undefined,
          price: sellerProduct ? Number(sellerProduct.price) : undefined,
          stock: sellerProduct?.stock || undefined,
          tags: productTags.filter((tag) => tag !== null),
        };
      })
    );

    return {
      data: productsWithDetails,
      total: productsWithDetails.length,
    };
  }

  async getProduct(id: number) {
    // TODO: Get product by ID
    return { id, name: "Product" };
  }

  async createProduct(data: any) {
    // TODO: Create product
    return { id: 1, ...data };
  }

  async updateProduct(id: number, data: any) {
    // TODO: Update product
    return { id, ...data };
  }

  async deleteProduct(id: number) {
    // TODO: Delete product
    return { message: "Product deleted" };
  }

  async getProductOptions(userId: number, langId: number = 1) {
    // Get all options for the user
    const options = await this.db
      .select()
      .from(productOptions)
      .where(and(eq(productOptions.sellerId, userId), eq(productOptions.deleted, false)));

    // Get language-specific names and values for each option
    const optionsWithDetails = await Promise.all(
      options.map(async (option) => {
        // Get option name in language
        const [optionLang] = await this.db
          .select()
          .from(productOptionsLang)
          .where(
            and(
              eq(productOptionsLang.optionId, option.id),
              eq(productOptionsLang.langId, langId)
            )
          )
          .limit(1);

        // Get option values
        const values = await this.db
          .select()
          .from(optionValues)
          .where(eq(optionValues.optionId, option.id))
          .orderBy(optionValues.displayOrder);

        // Get value names in language
        const valuesWithNames = await Promise.all(
          values.map(async (value) => {
            const [valueLang] = await this.db
              .select()
              .from(optionValuesLang)
              .where(
                and(
                  eq(optionValuesLang.optionValueId, value.id),
                  eq(optionValuesLang.langId, langId)
                )
              )
              .limit(1);

            return {
              id: value.id,
              optionId: value.optionId,
              identifier: value.identifier,
              name: valueLang?.name || "",
              colorCode: value.colorCode || undefined,
            };
          })
        );

        return {
          id: option.id,
          identifier: option.identifier,
          name: optionLang?.name || "",
          type: option.type,
          values: valuesWithNames,
        };
      })
    );

    return optionsWithDetails;
  }

  async createProductOption(userId: number, data: { name: string; type: number }) {
    // Generate identifier from name
    const identifier = data.name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-+|-+$/g, "");

    // Create the option
    const [newOption] = await this.db
      .insert(productOptions)
      .values({
        identifier,
        sellerId: userId,
        type: data.type,
        deleted: false,
        isSeparateImages: false,
        isColor: false,
        displayInFilter: false,
      })
      .returning();

    // Create language entry (default to langId = 1)
    await this.db.insert(productOptionsLang).values({
      optionId: newOption.id,
      langId: 1,
      name: data.name,
    });

    return {
      id: newOption.id,
      identifier: newOption.identifier,
      name: data.name,
      type: newOption.type,
      values: [],
    };
  }

  async createOptionValue(data: {
    optionId: number;
    name: string;
    colorCode?: string;
  }) {
    // Generate identifier from name
    const identifier = data.name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-+|-+$/g, "");

    // Get current max display order for this option
    const existingValues = await this.db
      .select()
      .from(optionValues)
      .where(eq(optionValues.optionId, data.optionId));

    const displayOrder = existingValues.length;

    // Create the option value
    const [newValue] = await this.db
      .insert(optionValues)
      .values({
        optionId: data.optionId,
        identifier,
        colorCode: data.colorCode || "",
        displayOrder,
      })
      .returning();

    // Create language entry (default to langId = 1)
    await this.db.insert(optionValuesLang).values({
      optionValueId: newValue.id,
      langId: 1,
      name: data.name,
    });

    return {
      id: newValue.id,
      optionId: newValue.optionId,
      identifier: newValue.identifier,
      name: data.name,
      colorCode: data.colorCode || undefined,
    };
  }

  async addTagsToProduct(
    productId: number,
    tagNames: string[],
    langId: number = 1
  ) {
    // Get or create tags for each tag name
    const tagIds: number[] = [];

    for (const tagName of tagNames) {
      if (!tagName.trim()) continue;

      // Generate identifier from name
      const identifier = tagName
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, "-")
        .replace(/^-+|-+$/g, "");

      // Check if tag already exists
      let [existingTag] = await this.db
        .select()
        .from(tags)
        .where(eq(tags.identifier, identifier))
        .limit(1);

      let tagId: number;

      if (existingTag) {
        tagId = existingTag.id;
        // Update language entry if needed
        const [existingLang] = await this.db
          .select()
          .from(tagsLang)
          .where(
            and(eq(tagsLang.tagId, tagId), eq(tagsLang.langId, langId))
          )
          .limit(1);

        if (!existingLang) {
          await this.db.insert(tagsLang).values({
            tagId,
            langId,
            name: tagName,
          });
        }
      } else {
        // Create new tag
        const [newTag] = await this.db
          .insert(tags)
          .values({
            identifier,
            active: true,
          })
          .returning();

        tagId = newTag.id;

        // Create language entry
        await this.db.insert(tagsLang).values({
          tagId,
          langId,
          name: tagName,
        });
      }

      tagIds.push(tagId);
    }

    // Remove existing product-tag relationships for this product
    await this.db
      .delete(productToTags)
      .where(eq(productToTags.productId, productId));

    // Create new product-tag relationships
    if (tagIds.length > 0) {
      await this.db.insert(productToTags).values(
        tagIds.map((tagId) => ({
          productId,
          tagId,
        }))
      );
    }

    return { success: true, tagIds };
  }

  async activateProduct(productId: number) {
    const [product] = await this.db
      .select()
      .from(products)
      .where(eq(products.id, productId))
      .limit(1);

    if (!product) {
      throw new NotFoundException("Product not found");
    }

    await this.db
      .update(products)
      .set({ active: true })
      .where(eq(products.id, productId));

    return { success: true };
  }

  async deactivateProduct(productId: number) {
    const [product] = await this.db
      .select()
      .from(products)
      .where(eq(products.id, productId))
      .limit(1);

    if (!product) {
      throw new NotFoundException("Product not found");
    }

    await this.db
      .update(products)
      .set({ active: false })
      .where(eq(products.id, productId));

    return { success: true };
  }

  async bulkActivateProducts(productIds: number[]) {
    if (productIds.length === 0) {
      return { success: true, count: 0 };
    }

    await this.db
      .update(products)
      .set({ active: true })
      .where(inArray(products.id, productIds));

    return { success: true, count: productIds.length };
  }

  async bulkDeactivateProducts(productIds: number[]) {
    if (productIds.length === 0) {
      return { success: true, count: 0 };
    }

    await this.db
      .update(products)
      .set({ active: false })
      .where(inArray(products.id, productIds));

    return { success: true, count: productIds.length };
  }

  async bulkDeleteProducts(productIds: number[]) {
    if (productIds.length === 0) {
      return { success: true, count: 0 };
    }

    await this.db
      .update(products)
      .set({ deleted: true })
      .where(inArray(products.id, productIds));

    return { success: true, count: productIds.length };
  }

  async getProductForClone(productId: number, langId: number = 1) {
    const [product] = await this.db
      .select()
      .from(products)
      .where(and(eq(products.id, productId), eq(products.deleted, false)))
      .limit(1);

    if (!product) {
      throw new NotFoundException("Product not found");
    }

    // Get language-specific data
    const [productLang] = await this.db
      .select()
      .from(productsLang)
      .where(
        and(
          eq(productsLang.productId, product.id),
          eq(productsLang.langId, langId)
        )
      )
      .limit(1);

    // Get categories
    const productCategories = await this.db
      .select()
      .from(productToCategory)
      .where(eq(productToCategory.productId, product.id));

    // Get tags
    const productTagRelations = await this.db
      .select()
      .from(productToTags)
      .where(eq(productToTags.productId, product.id));

    const tagIds = productTagRelations.map((rel) => rel.tagId);
    const productTags =
      tagIds.length > 0
        ? (
            await Promise.all(
              tagIds.map(async (tagId) => {
                const [tagLang] = await this.db
                  .select()
                  .from(tagsLang)
                  .where(
                    and(eq(tagsLang.tagId, tagId), eq(tagsLang.langId, langId))
                  )
                  .limit(1);
                return tagLang?.name || null;
              })
            )
          ).filter((name) => name !== null)
        : [];

    // Get seller product data
    const [sellerProduct] = await this.db
      .select()
      .from(sellerProducts)
      .where(eq(sellerProducts.productId, product.id))
      .limit(1);

    const [sellerProductLang] = sellerProduct
      ? await this.db
          .select()
          .from(sellerProductsLang)
          .where(
            and(
              eq(sellerProductsLang.sellerProductId, sellerProduct.id),
              eq(sellerProductsLang.langId, langId)
            )
          )
          .limit(1)
      : [null];

    // Return clone data (excluding name and images)
    return {
      description: productLang?.description || "",
      shortDescription: productLang?.shortDescription || "",
      occasion: product.occasion || "",
      categoryIds: productCategories.map((pc) => pc.categoryId),
      tags: productTags,
      weight: product.weight ? Number(product.weight) : undefined,
      weightUnit: product.weightUnit || undefined,
      canBeCustom: product.canBeCustom,
      customPrompt: product.customPrompt || "",
      featured: product.featured,
      // Seller product data
      price: sellerProduct ? Number(sellerProduct.price) : undefined,
      costPrice: sellerProduct?.costPrice
        ? Number(sellerProduct.costPrice)
        : undefined,
      stock: sellerProduct?.stock || undefined,
      minOrderQty: sellerProduct?.minOrderQty || undefined,
      trackInventory: sellerProduct?.trackInventory ?? true,
      condition: sellerProductLang?.condition || "",
    };
  }

  async getOccasions(): Promise<string[]> {
    // Get distinct occasions from products table
    const allProducts = await this.db
      .select({ occasion: products.occasion })
      .from(products)
      .where(eq(products.deleted, false));

    // Extract unique, non-null occasions
    const occasionsSet = new Set<string>();
    allProducts.forEach((product: { occasion: string | null }) => {
      if (product.occasion && product.occasion.trim()) {
        occasionsSet.add(product.occasion.trim());
      }
    });

    return Array.from(occasionsSet).sort();
  }

  async getProductCategories(langId: number = 1) {
    // Get all active categories
    const categoriesList = await this.db
      .select()
      .from(productCategories)
      .where(eq(productCategories.active, true));

    // Get language-specific names for each category
    const categoriesWithNames = await Promise.all(
      categoriesList.map(async (category: any) => {
        const [categoryLang] = await this.db
          .select()
          .from(productCategoriesLang)
          .where(
            and(
              eq(productCategoriesLang.categoryId, category.id),
              eq(productCategoriesLang.langId, langId)
            )
          )
          .limit(1);

        return {
          id: category.id,
          identifier: category.identifier,
          name: categoryLang?.name || "",
          parentId: category.parentId,
          type: category.type || undefined, // Add type if it exists in schema
        };
      })
    );

    return categoriesWithNames.filter((cat) => cat.name);
  }
}

