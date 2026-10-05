{
  "PHP final class": {
    "scope": "php",
    "prefix": "fclass",
    "description": "Final class con strict_types",
    "body": [
      "declare(strict_types=1);",
      "",
      "namespace ${RELATIVE_FILEPATH/@@REGEX@@/@@FORMAT@@/g};",
      "",
      "final class ${1:${TM_FILENAME_BASE}}",
      "{",
      "\t$0",
      "}",
      ""
    ]
  },
  "PHP enum": {
    "scope": "php",
    "prefix": "fenum",
    "description": "Enum con strict_types",
    "body": [
      "declare(strict_types=1);",
      "",
      "namespace ${RELATIVE_FILEPATH/@@REGEX@@/@@FORMAT@@/g};",
      "",
      "enum ${1:${TM_FILENAME_BASE}}",
      "{",
      "\t$0",
      "}",
      ""
    ]
  },
  "PHP interface": {
    "scope": "php",
    "prefix": "finterface",
    "description": "Interface con strict_types",
    "body": [
      "declare(strict_types=1);",
      "",
      "namespace ${RELATIVE_FILEPATH/@@REGEX@@/@@FORMAT@@/g};",
      "",
      "interface ${1:${TM_FILENAME_BASE}}",
      "{",
      "\t$0",
      "}",
      ""
    ]
  },
  "PHP trait": {
    "scope": "php",
    "prefix": "ftrait",
    "description": "Trait con strict_types",
    "body": [
      "declare(strict_types=1);",
      "",
      "namespace ${RELATIVE_FILEPATH/@@REGEX@@/@@FORMAT@@/g};",
      "",
      "trait ${1:${TM_FILENAME_BASE}}",
      "{",
      "\t$0",
      "}",
      ""
    ]
  }
}
