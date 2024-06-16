<?php
require '../vendor/autoload.php';

use GuzzleHttp\Client;

header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);

$text = $data['text'];
$targetLang = $data['targetLang'];

$apiKey = 'YOUR_LECTO_AI_API_KEY'; // Replace with your actual API key

$client = new Client();
$response = $client->request('POST', 'https://api.lecto.ai/v1/translate', [
    'json' => [
        'text' => $text,
        'target_lang' => $targetLang
    ],
    'headers' => [
        'Authorization' => 'Bearer ' . $apiKey
    ]
]);

$responseBody = json_decode($response->getBody(), true);

echo json_encode([
    'translatedText' => $responseBody['translatedText']
]);
?>
