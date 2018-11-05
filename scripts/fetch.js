import { log } from "./Debug.mjs";

const url = "https://raw.githubusercontent.com/hyperium/hyper/master/examples/client.rs";

main();

async function main() {
    let codeElement = getCodeElement();
    codeElement.textContent = await getCode();
}

async function getCode() {
    let code = await
        fetch(url)
            .then(
                (response) => {
                    if (response.ok) {
                        return response.text();
                    }
                }
            );
    return code;
}

function getCodeElement() {
    return document.getElementById("code");
}