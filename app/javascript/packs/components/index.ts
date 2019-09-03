import App from './main';
import { ComponentManager, setPropertyDidChange } from '@glimmer/component';
import initializeCustomElements from '@glimmer/web-component';

const app = new App();

declare const ADVOCATE;

setPropertyDidChange(() => {
  app.scheduleRerender();
});

app.registerInitializer({
  initialize(registry) {
    registry.register(`component-manager:/${app.rootName}/component-managers/main`, ComponentManager)
  }
});

// GLOBAL from application.js
ADVOCATE.document_ready(() => {
  const containerElement = document.getElementById('messages-app'); // div id=messages-app
  app.renderComponent('messages-app', containerElement, null);

  app.boot();

  initializeCustomElements(app, ['messages-app']); // <messages-app>
});
