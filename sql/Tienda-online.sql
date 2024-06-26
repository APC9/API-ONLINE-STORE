CREATE TYPE "roles" AS ENUM (
  'admin_role',
  'user_role'
);

CREATE TYPE "product_status" AS ENUM (
  'in_stock',
  'out_of_stock',
  'low_stock'
);

CREATE TYPE "cart_status" AS ENUM (
  'active',
  'pending',
  'completed'
);

CREATE TYPE "type_addres" AS ENUM (
  'billing',
  'shipping'
);

CREATE TYPE "order_status" AS ENUM (
  'pending',
  'processing',
  'shipped',
  'delivered',
  'cancelled'
);

CREATE TABLE "users" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "first_name" varchar(100) NOT NULL,
  "last_Name" varchar(100) NOT NULL,
  "email" varchar(100) UNIQUE NOT NULL,
  "phone_number" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "picture" varchar,
  "roles" roles,
  "is_google" BOOLEAN,
  "isActive" BOOLEAN,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "address" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_id" int,
  "type" type_addres,
  "street" varchar,
  "city" varchar,
  "country" varchar,
  "postal_code" int,
  "additional_data" varchar
);

CREATE TABLE "colors" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "color" varchar(50),
  "store_id" int
);

CREATE TABLE "stores" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar UNIQUE NOT NULL,
  "phone_number" varchar UNIQUE NOT NULL,
  "description" text,
  "slug" varchar,
  "image_url" varchar,
  "isActive" BOOLEAN,
  "user_id" int,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "categories" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar NOT NULL,
  "description" text,
  "isActive" BOOLEAN,
  "store_id" int,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "categories_products" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "category_id" int,
  "product_id" int
);

CREATE TABLE "products" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar NOT NULL,
  "sku" varchar(20),
  "description" text,
  "price" decimal NOT NULL,
  "status" product_status,
  "stock" int NOT NULL,
  "isActive" BOOLEAN,
  "images_urls" text,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "carts" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_id" int,
  "status" cart_status,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "cart_items" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "product_id" int,
  "cart_id" int,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "orders" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_id" int,
  "address_id" int,
  "cart_id" int,
  "order_status" order_status,
  "created_at" timestamp DEFAULT 'now()'
);

ALTER TABLE "stores" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "colors" ADD FOREIGN KEY ("store_id") REFERENCES "stores" ("id");

ALTER TABLE "categories" ADD FOREIGN KEY ("store_id") REFERENCES "stores" ("id");

ALTER TABLE "categories_products" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "categories_products" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "carts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "cart_items" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "cart_items" ADD FOREIGN KEY ("cart_id") REFERENCES "carts" ("id");

ALTER TABLE "address" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("address_id") REFERENCES "address" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("cart_id") REFERENCES "carts" ("id");
