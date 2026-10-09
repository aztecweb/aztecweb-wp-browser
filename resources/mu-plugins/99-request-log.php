<?php
// TEMPORARY diagnostic: log every WordPress request with timing, status and redirect.
$GLOBALS['__rl_start'] = microtime(true);
register_shutdown_function(static function () {
    $location = '';
    foreach (headers_list() as $h) {
        if (stripos($h, 'Location:') === 0) { $location = trim(substr($h, 9)); }
    }
    $cookies = [];
    foreach (headers_list() as $h) {
        if (stripos($h, 'Set-Cookie:') === 0) { $cookies[] = strtok(trim(substr($h, 11)), '='); }
    }
    $line = sprintf(
        "%s %.3fs %s %s %d loc=%s setcookie=%s reqcookies=%s post=%s\n",
        date('H:i:s', (int) $GLOBALS['__rl_start']) . substr(sprintf('%.3f', fmod($GLOBALS['__rl_start'], 1)), 1),
        microtime(true) - $GLOBALS['__rl_start'],
        $_SERVER['REQUEST_METHOD'] ?? '-',
        $_SERVER['REQUEST_URI'] ?? '-',
        http_response_code(),
        $location,
        implode(',', $cookies),
        implode(',', array_keys($_COOKIE)),
        implode(',', array_keys($_POST))
    );
    @file_put_contents(dirname(__DIR__, 3) . '/tests/_output/requests.log', $line, FILE_APPEND);
});
