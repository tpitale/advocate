import Component, { tracked } from "@glimmer/component";
declare const ADVOCATE;

export default class Messages extends Component {
  @tracked state = {
    events: [],
    events_empty: true
  };

  interaction_id = null;

  constructor(options) {
    super(options);

    this.load_interaction_id();
    this.load_default_events();

    // GLOBAL
    ADVOCATE.subscribe(this, this.interaction_id);
  }

  load_interaction_id() {
    this.interaction_id = document.getElementById("messages-app").dataset["interaction-id"];
  }

  load_default_events() {
    // this.element?
    console.log(this.element);
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
