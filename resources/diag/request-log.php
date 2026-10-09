<?php
// TEMPORARY diagnostic: log the start and end of every built-in server request.
if (PHP_SAPI === 'cli-server') {
    $GLOBALS['__rl_start'] = microtime(true);
    $GLOBALS['__rl_file'] = dirname(__DIR__, 2) . '/tests/_output/requests.log';
    $GLOBALS['__rl_id'] = substr(md5(uniqid('', true)), 0, 6);
    $stamp = static fn (float $t): string => date('H:i:s', (int) $t) . substr(sprintf('%.3f', fmod($t, 1)), 1);
    @file_put_contents($GLOBALS['__rl_file'], sprintf(
        "%s START %s %s %s cookies=%s\n",
        $stamp($GLOBALS['__rl_start']),
        $GLOBALS['__rl_id'],
        $_SERVER['REQUEST_METHOD'] ?? '-',
        $_SERVER['REQUEST_URI'] ?? '-',
        implode(',', array_map(static fn ($k) => substr($k, 0, 22), array_keys($_COOKIE)))
    ), FILE_APPEND);
    register_shutdown_function(static function () use ($stamp) {
        $location = '';
        foreach (headers_list() as $h) {
            if (stripos($h, 'Location:') === 0) {
                $location = trim(substr($h, 9));
            }
        }
        $error = error_get_last();
        @file_put_contents($GLOBALS['__rl_file'], sprintf(
            "%s END   %s %.3fs %d loc=%s err=%s\n",
            $stamp(microtime(true)),
            $GLOBALS['__rl_id'],
            microtime(true) - $GLOBALS['__rl_start'],
            http_response_code(),
            $location,
            $error ? substr($error['message'], 0, 200) : ''
        ), FILE_APPEND);
    });
}
