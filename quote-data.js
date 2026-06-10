/**
 * Edit per couple → open quote.html → Save as PDF (Background graphics ON)
 *
 * Logo: assets/logo.png (transparent PNG). Page 1 uses text wordmark only;
 * metallic image logo appears small in page 2 footer. Set showLogoOnCover: true
 * to place a small image below hero instead. stripLogoBlack: true only if
 * the PNG has a baked-in black background.
 *
 * Photos: hero.jpg, still-1.png (B&W vows — NOT still-1.jpg). Leave "" for whitespace.
 */
window.QUOTE_DATA = {
  logo: "assets/logo.png",
  stripLogoBlack: false,
  showLogoOnCover: false,
  brandName: "Favor3D Productions",

  bride: "Savannah",
  groom: "Elijah",
  brideFull: "Savannah Newell",
  groomFull: "Elijah Hamilton",
  date: "May 10, 2025",
  venue: "The Estate at Cherokee Dock",
  city: "Atlanta, Georgia",

  investmentRange: "$2,750–$3,500",
  recommended: "gold",

  welcome:
    "Savannah and Elijah — thank you for inviting us into your wedding at The Estate at Cherokee Dock. We would be honored to film your May celebration with two cinematographers, intentional coverage, and a film you will return to for years.",

  testimonial: {
    quote: "The film captured everything we missed in the moment — we still watch it on anniversaries.",
    author: "J. & M., Atlanta",
  },

  signOff: "Warmly, Favor3D Productions",

  heroImage: "assets/photos/hero.jpg",
  stillImage: "assets/photos/still-1.png?v=15",

  photos: {
    hero: { position: "center 32%" },
    still: { mono: true, position: "center 42%" },
  },

  retainerPercent: 10,
  balanceDue: "14 days prior to your wedding",

  addon: {
    price: 500,
    title: "Guestbook film",
    description: "1–2 minute edit of guest messages, delivered with your highlight.",
  },

  // Fill in your real contact details before sending to clients
  contact: {
    email: "hello@favor3d.com", // ← your real email
    phone: "", // ← e.g. "(404) 555-0100"
    website: "favor3d.com",
    instagram: "@favor3dproductions", // ← your handle
    city: "Atlanta, Georgia",
  },
};

window.PACKAGES = {
  bronze: {
    name: "Bronze",
    displayName: "Essential",
    price: 2750,
    hours: 8,
    cinematographers: 2,
    bestFor: "Full-day coverage with cinematic highlight",
    features: [
      "2–4 minute cinematic highlight film",
      "Professional vow & speech audio",
      "Prep through reception coverage",
    ],
  },
  silver: {
    name: "Silver",
    displayName: "Signature",
    price: 3000,
    hours: 10,
    cinematographers: 2,
    bestFor: "Extended day + teaser for sharing",
    features: [
      "4–6 minute cinematic highlight film",
      "60-second social teaser",
      "Private digital gallery & download",
    ],
  },
  gold: {
    name: "Gold",
    displayName: "Heirloom",
    price: 3500,
    hours: 12,
    cinematographers: 2,
    bestFor: "Full celebration + drone cinematography",
    features: [
      "6–8 minute cinematic highlight film",
      "Aerial drone footage (venue permitting)",
      "Teaser + digital gallery delivery",
    ],
  },
};
