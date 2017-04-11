import { ResolverConfiguration } from '@glimmer/resolver';

export default <ResolverConfiguration>{
  "app": {
    "name": "messages-app",
    "rootName": "messages-app"
  },
  "types": {
    "application": {
      "definitiveCollection": "main"
    },
    "component": {
      "definitiveCollection": "components"
    },
    "helper": {
      "definitiveCollection": "components"
    },
    "renderer": {
      "definitiveCollection": "main"
    },
    "template": {
      "definitiveCollection": "components"
    }
  },
  "collections": {
    "main": {
      "types": ["application", "renderer"]
    },
    "components": {
      "group": "ui",
      "types": ["component", "template", "helper"],
      "defaultType": "component",
      "privateCollections": ["utils"]
    },
    "styles": {
      "group": "ui", "unresolvable": true
    },
    "utils": {
      "unresolvable": true
    }
  }
};
