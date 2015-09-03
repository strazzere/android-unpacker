/*
 * Header file for the definitions of packers/protectors
 *
 * Tim "diff" Strazzere <strazz@gmail.com>
 */

typedef struct {
  char* name;
  char* description;
  char* filter;
  char* marker;
} packer;

static packer packers[] = {

  // APKProtect
  {
    "APKProtect v1->5",
    "APKProtect generialized detection",
    // This is actually the filter APKProtect uses itself for finding it's own odex to modify
    ".apk@",
    "/libAPKProtect"
  },

  // LIAPP
  {
    "LIAPP 'Egg' (v1->?)",
    "LockIn APP (lockincomp.com)",
    "LIAPPEgg.dex",
    "/LIAPPEgg"
  },

  // Qihoo 'Monster'
  {
    "Qihoo 'Monster' (v1->?)",
    "Qihoo unknown version, code named 'monster'",
    "monster.dex",
    "/libprotectClass"
  }
};
