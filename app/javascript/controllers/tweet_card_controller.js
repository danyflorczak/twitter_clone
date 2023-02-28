import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tweet-card"
export default class extends Controller {
  connect() {
    console.log("hello world from tweet card controller")

    this.element.addEventListener('click', (e) => {
      if (![e.target.dataset.ignoreClick, e.target.parentElement.dataset.ignoreClick].includes("true")) {
        Turbo.visit(this.element.dataset.tweetPath);
      }
    });
  }
}
