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
