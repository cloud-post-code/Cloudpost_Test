/**
 * Database seeder script
 * Generates synthetic data for testing using Faker.js
 */

import "dotenv/config";
import { faker } from "@faker-js/faker";
import { db } from "./db";
import * as schema from "./schema";
import { sql } from "drizzle-orm";

async function seed() {
  console.log("Starting database seeding...");

  try {
    // Seed Languages
    console.log("Seeding languages...");
    const languages = await db
      .insert(schema.languages)
      .values([
        { code: "en", name: "English", active: true, layoutDirection: "ltr" },
        { code: "es", name: "Spanish", active: true, layoutDirection: "ltr" },
        { code: "fr", name: "French", active: true, layoutDirection: "ltr" },
      ])
      .returning();

    const enLangId = languages.find((l) => l.code === "en")?.id || 1;

    // Seed Countries
    console.log("Seeding countries...");
    const countries = await db
      .insert(schema.countries)
      .values([
        { code: "US", active: true },
        { code: "CA", active: true },
        { code: "GB", active: true },
        { code: "AU", active: true },
      ])
      .returning();

    const usCountryId = countries.find((c) => c.code === "US")?.id || 1;

    // Seed Countries Lang
    await db.insert(schema.countriesLang).values(
      countries.map((country) => ({
        countryId: country.id,
        langId: enLangId,
        name: country.code === "US" ? "United States" : country.code,
      }))
    );

    // Seed States
    console.log("Seeding states...");
    const states = await db
      .insert(schema.states)
      .values([
        { countryId: usCountryId, code: "CA", active: true },
        { countryId: usCountryId, code: "NY", active: true },
        { countryId: usCountryId, code: "TX", active: true },
        { countryId: usCountryId, code: "FL", active: true },
      ])
      .returning();

    await db.insert(schema.statesLang).values(
      states.map((state) => ({
        stateId: state.id,
        langId: enLangId,
        name: state.code === "CA" ? "California" : state.code,
      }))
    );

    const caStateId = states.find((s) => s.code === "CA")?.id || 1;

    // Seed Currencies
    console.log("Seeding currencies...");
    const currencies = await db
      .insert(schema.currencies)
      .values([
        { code: "USD", symbolLeft: "$", active: true },
        { code: "EUR", symbolRight: "€", active: true },
        { code: "GBP", symbolLeft: "£", active: true },
      ])
      .returning();

    await db.insert(schema.currenciesLang).values(
      currencies.map((currency) => ({
        currencyId: currency.id,
        langId: enLangId,
        name: currency.code,
      }))
    );

    // Seed Users (Sellers and Buyers)
    console.log("Seeding users...");
    const sellers = [];
    const buyers = [];

    // Create 5 sellers
    for (let i = 0; i < 5; i++) {
      const seller = await db
        .insert(schema.users)
        .values({
          name: faker.person.fullName(),
          phoneDcode: "+1",
          phone: BigInt(faker.phone.number().replace(/\D/g, "").slice(0, 10)),
          dob: faker.date.birthdate({ min: 25, max: 65, mode: "age" }),
          profileInfo: faker.lorem.paragraph(),
          address1: faker.location.streetAddress(),
          address2: faker.location.secondaryAddress(),
          zip: faker.location.zipCode(),
          countryId: usCountryId,
          stateId: caStateId,
          city: faker.location.city(),
          isBuyer: false,
          isSupplier: true,
          isAdvertiser: false,
          isAffiliate: false,
          registeredInitiallyFor: 2, // Seller
          preferredDashboard: 2,
        })
        .returning();

      sellers.push(seller[0]);

      // Create credentials for seller
      await db.insert(schema.userCredentials).values({
        userId: seller[0].id,
        username: faker.internet.userName(),
        email: faker.internet.email(),
        password: "$2a$10$dummyhash", // Dummy hash for testing
        active: 1,
        verified: 1,
      });
    }

    // Create 10 buyers
    for (let i = 0; i < 10; i++) {
      const buyer = await db
        .insert(schema.users)
        .values({
          name: faker.person.fullName(),
          phoneDcode: "+1",
          phone: BigInt(faker.phone.number().replace(/\D/g, "").slice(0, 10)),
          dob: faker.date.birthdate({ min: 18, max: 80, mode: "age" }),
          profileInfo: "",
          address1: faker.location.streetAddress(),
          address2: faker.location.secondaryAddress(),
          zip: faker.location.zipCode(),
          countryId: usCountryId,
          stateId: caStateId,
          city: faker.location.city(),
          isBuyer: true,
          isSupplier: false,
          registeredInitiallyFor: 1, // Buyer
          preferredDashboard: 1,
        })
        .returning();

      buyers.push(buyer[0]);

      // Create credentials for buyer
      await db.insert(schema.userCredentials).values({
        userId: buyer[0].id,
        username: faker.internet.userName(),
        email: faker.internet.email(),
        password: "$2a$10$dummyhash",
        active: 1,
        verified: 1,
      });
    }

    // Seed Shops
    console.log("Seeding shops...");
    const shops = [];
    for (const seller of sellers) {
      const shop = await db
        .insert(schema.shops)
        .values({
          userId: seller.id,
          identifier: faker.string.alphanumeric(10).toLowerCase(),
          active: true,
          featured: faker.datatype.boolean(),
        })
        .returning();

      shops.push(shop[0]);

      // Create shop language data
      await db.insert(schema.shopsLang).values({
        shopId: shop[0].id,
        langId: enLangId,
        name: faker.company.name(),
        description: faker.company.catchPhrase(),
        policy: faker.lorem.paragraph(),
        returnPolicy: faker.lorem.paragraph(),
        shippingPolicy: faker.lorem.paragraph(),
      });
    }

    // Seed Product Categories
    console.log("Seeding product categories...");
    const categories = await db
      .insert(schema.productCategories)
      .values([
        { identifier: "electronics", active: true, featured: true },
        { identifier: "clothing", active: true, featured: true },
        { identifier: "books", active: true, featured: false },
        { identifier: "home", active: true, featured: true },
      ])
      .returning();

    await db.insert(schema.productCategoriesLang).values(
      categories.map((cat) => ({
        categoryId: cat.id,
        langId: enLangId,
        name: cat.identifier.charAt(0).toUpperCase() + cat.identifier.slice(1),
        description: faker.lorem.sentence(),
      }))
    );

    // Seed Products
    console.log("Seeding products...");
    const products = [];
    for (let i = 0; i < 20; i++) {
      const seller = faker.helpers.arrayElement(sellers);
      const category = faker.helpers.arrayElement(categories);

      const product = await db
        .insert(schema.products)
        .values({
          sellerId: seller.id,
          identifier: faker.string.alphanumeric(15).toLowerCase(),
          type: 0,
          active: true,
          deleted: false,
        })
        .returning();

      products.push(product[0]);

      // Create product language data
      await db.insert(schema.productsLang).values({
        productId: product[0].id,
        langId: enLangId,
        name: faker.commerce.productName(),
        description: faker.commerce.productDescription(),
        shortDescription: faker.lorem.sentence(),
      });

      // Link product to category
      await db.insert(schema.productToCategory).values({
        productId: product[0].id,
        categoryId: category.id,
      });

      // Create seller product
      const shop = shops.find((s) => s.userId === seller.id);
      if (shop) {
        await db.insert(schema.sellerProducts).values({
          productId: product[0].id,
          userId: seller.id,
          sku: faker.string.alphanumeric(10).toUpperCase(),
          price: faker.commerce.price({ min: 10, max: 1000, dec: 2 }),
          costPrice: faker.commerce.price({ min: 5, max: 500, dec: 2 }),
          stock: faker.number.int({ min: 0, max: 1000 }),
          minOrderQty: 1,
          trackInventory: true,
          active: true,
          deleted: false,
        });

        await db.insert(schema.sellerProductsLang).values({
          sellerProductId: product[0].id,
          langId: enLangId,
          title: faker.commerce.productName(),
          options: "",
        });
      }
    }

    // Seed Orders
    console.log("Seeding orders...");
    const orderStatuses = await db
      .insert(schema.orderStatus)
      .values([
        { identifier: "pending", active: true, colorClass: "warning" },
        { identifier: "confirmed", active: true, colorClass: "info" },
        { identifier: "shipped", active: true, colorClass: "primary" },
        { identifier: "delivered", active: true, colorClass: "success" },
        { identifier: "cancelled", active: true, colorClass: "danger" },
      ])
      .returning();

    await db.insert(schema.orderStatusLang).values(
      orderStatuses.map((status) => ({
        statusId: status.id,
        langId: enLangId,
        name: status.identifier.charAt(0).toUpperCase() + status.identifier.slice(1),
      }))
    );

    const pendingStatusId = orderStatuses.find((s) => s.identifier === "pending")?.id || 1;

    for (let i = 0; i < 15; i++) {
      const buyer = faker.helpers.arrayElement(buyers);
      const order = await db
        .insert(schema.orders)
        .values({
          userId: buyer.id,
          number: `ORD-${faker.string.alphanumeric(10).toUpperCase()}`,
          netAmount: faker.commerce.price({ min: 50, max: 500, dec: 2 }),
          paymentMethodId: 1,
        })
        .returning();

      // Create order products
      const numProducts = faker.number.int({ min: 1, max: 3 });
      for (let j = 0; j < numProducts; j++) {
        const product = faker.helpers.arrayElement(products);
        await db.insert(schema.orderProducts).values({
          orderId: order[0].id,
          sellerProductId: product.id,
          invoiceNumber: `INV-${faker.string.alphanumeric(8).toUpperCase()}`,
          qty: faker.number.int({ min: 1, max: 5 }),
          unitPrice: faker.commerce.price({ min: 10, max: 100, dec: 2 }),
          totalPrice: faker.commerce.price({ min: 20, max: 500, dec: 2 }),
          statusId: pendingStatusId,
          options: "",
          productName: faker.commerce.productName(),
          brandName: faker.company.name(),
          otherCharges: "0",
          taxCollectedBySeller: false,
          roundingOff: "0",
        });
      }
    }

    console.log("Database seeding completed successfully!");
  } catch (error) {
    console.error("Error seeding database:", error);
    throw error;
  }
}

seed()
  .then(() => {
    console.log("Seeding process completed");
    process.exit(0);
  })
  .catch((error) => {
    console.error("Seeding failed:", error);
    process.exit(1);
  });

