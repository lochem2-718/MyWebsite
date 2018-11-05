import { log } from "./Debug.mjs";
const url = "https://raw.githubusercontent.com/hyperium/hyper/master/examples/client.rs";
let text = "";

function getCode() {
    fetch(url)
        .then(
            (response) => {
                if (response.ok) { return log("body", response.body); }
            }
        )
        .then(
            (data) => { return log("reader", data.getReader()); }
        )
        .then(
            (reader) => { return log("reader2", reader.read()); }
        )
        .then(
            ({ done, value }) => {
                if (!done) { text += log("section", value); }
            });
}

getCode();

let code = document.getElementById("code");
code.textContent = text;