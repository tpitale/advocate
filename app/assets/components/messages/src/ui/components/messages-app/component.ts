import Component, { tracked } from "@glimmer/component";
declare const ADVOCATE;

export default class Messages extends Component {
  @tracked state = {
    events: [],
    events_empty: true
  }

  constructor(options) {
    super(options);

    this.load_default_events();
    // periodically fetch events?

    // GLOBAL
    ADVOCATE.subscribe(this);
  }

  load_default_events() {
    // this.element?
    let default_events = JSON.parse(document.getElementById("messages-app").dataset.events);

    this.state = {
      events: default_events,
      events_empty: (default_events.length <= 0)
    };
  }

  add_event(data) {
    let new_events = Array.of(data).concat(this.state.events);

    this.state = {
      events: new_events,
      events_empty: (new_events.length <= 0)
    };
  }
}
