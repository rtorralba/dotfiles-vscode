<?php

declare(strict_types=1);

// Uso: php generate-snippets.php <composer.json> <plantilla>
// Escribe por stdout la plantilla de snippets con el mapeo PSR-4 de composer.json
// (autoload y autoload-dev). Sin composer.json o sin psr-4, usa "src" -> "App".

[, $composerPath, $templatePath] = $argv;

$composer = is_file($composerPath) ? json_decode((string) file_get_contents($composerPath), true) : null;

$map = [];
foreach (['autoload', 'autoload-dev'] as $section) {
    foreach (($composer[$section]['psr-4'] ?? []) as $namespace => $paths) {
        foreach ((array) $paths as $path) {
            $path = trim((string) preg_replace('#^\./#', '', $path), '/');
            $namespace = trim($namespace, '\\');
            if ($path !== '' && $namespace !== '') {
                $map[$path] = $namespace;
            }
        }
    }
}
if ($map === []) {
    $map = ['src' => 'App'];
}
// Las rutas más largas primero, por si una es prefijo de otra
uksort($map, fn (string $a, string $b): int => strlen($b) <=> strlen($a));

$regex = [];
$format = '';
$group = 0;
foreach ($map as $path => $namespace) {
    $group++;
    $regex[] = '^(' . preg_quote($path, '/') . ')(?=\/)';
    $format .= '${' . $group . ':+' . str_replace('\\', '\\\\', $namespace) . '}';
}
// Cualquier "/" restante pasa a "\" y el nombre del fichero se descarta
$regex = implode('|', $regex) . '|\/?[^\/]+\.php$|(\/)';
$format .= '${' . ($group + 1) . ':+\\\\}';

$escape = fn (string $s): string => substr(json_encode($s, JSON_UNESCAPED_SLASHES), 1, -1);

echo str_replace(
    ['@@REGEX@@', '@@FORMAT@@'],
    [$escape($regex), $escape($format)],
    (string) file_get_contents($templatePath),
);
