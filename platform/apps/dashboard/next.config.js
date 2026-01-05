/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  transpilePackages: ["@cloudpost/database", "@cloudpost/shared", "@cloudpost/ui"],
};

module.exports = nextConfig;

