#!/bin/bash

# Create directories
mkdir -p public_html/css
mkdir -p public_html/js
mkdir -p vendor
mkdir -p lecto_translation

# Create files
touch public_html/index.html
touch public_html/css/styles.css
touch public_html/js/script.js
touch public_html/api.php
touch lecto_translation/composer.json

# Add content to index.html
cat <<EOL > public_html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecto AI Translation</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <div class="container">
            <h1>Lecto AI Translation Service</h1>
        </div>
    </header>

    <main>
        <div class="container">
            <form id="translation-form">
                <label for="source-text">Text to translate:</label>
                <textarea id="source-text" rows="4" required></textarea>

                <label for="target-lang">Target Language:</label>
                <select id="target-lang" required>
                    <option value="es">Spanish</option>
                    <option value="fr">French</option>
                    <option value="de">German</option>
                    <option value="it">Italian</option>
                    <!-- Add more languages as needed -->
                </select>

                <button type="submit">Translate</button>
            </form>

            <div id="result">
                <h2>Translation:</h2>
                <p id="translated-text"></p>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Lecto AI Translation Service. All rights reserved.</p>
        </div>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
EOL

# Add content to styles.css
cat <<EOL > public_html/css/styles.css
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
    color: #333;
}

.container {
    width: 80%;
    margin: 0 auto;
}

header {
    background-color: #333;
    color: #fff;
    padding: 1rem 0;
    text-align: center;
}

main {
    padding: 2rem 0;
}

form {
    background: #fff;
    padding: 1rem;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

form label, form textarea, form select, form button {
    display: block;
    width: 100%;
    margin-bottom: 1rem;
}

form button {
    background-color: #333;
    color: #fff;
    border: none;
    padding: 0.5rem;
    cursor: pointer;
    border-radius: 5px;
}

form button:hover {
    background-color: #555;
}

#result {
    margin-top: 2rem;
    background: #fff;
    padding: 1rem;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
EOL

# Add content to script.js
cat <<EOL > public_html/js/script.js
document.getElementById('translation-form').addEventListener('submit', async function(e) {
    e.preventDefault();

    const sourceText = document.getElementById('source-text').value;
    const targetLang = document.getElementById('target-lang').value;

    try {
        const response = await fetch('/api.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                text: sourceText,
                targetLang: targetLang
            })
        });

        const data = await response.json();
        document.getElementById('translated-text').innerText = data.translatedText;
    } catch (error) {
        console.error('Error:', error);
    }
});
EOL

# Add content to api.php
cat <<EOL > public_html/api.php
<?php
require '../vendor/autoload.php';

use GuzzleHttp\Client;

header('Content-Type: application/json');

\$data = json_decode(file_get_contents('php://input'), true);

\$text = \$data['text'];
\$targetLang = \$data['targetLang'];

\$apiKey = 'YOUR_LECTO_AI_API_KEY'; // Replace with your actual API key

\$client = new Client();
\$response = \$client->request('POST', 'https://api.lecto.ai/v1/translate', [
    'json' => [
        'text' => \$text,
        'target_lang' => \$targetLang
    ],
    'headers' => [
        'Authorization' => 'Bearer ' . \$apiKey
    ]
]);

\$responseBody = json_decode(\$response->getBody(), true);

echo json_encode([
    'translatedText' => \$responseBody['translatedText']
]);
?>
EOL

# Add content to composer.json
cat <<EOL > lecto_translation/composer.json
{
    "require": {
        "guzzlehttp/guzzle": "^7.0"
    }
}
EOL

# Display completion message
echo "Project structure created successfully."
