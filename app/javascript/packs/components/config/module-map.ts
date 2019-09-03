import Messages from '../messages-app/component';
import MessageEvent from '../message-event/component';

const messages_template = require('../messages-app/template.hbs');
const message_event_template = require('../message-event/template.hbs');

console.log(messages_template);

export default {
  'component:/messages-app/components/message-event': MessageEvent,
  'template:/messages-app/components/message-event': messages_template,
  'component:/messages-app/components/messages-app': Messages,
  'template:/messages-app/components/messages-app': message_event_template
};
