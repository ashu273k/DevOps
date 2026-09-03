import { mkdir, writeFile } from 'node:fs/promises';

await mkdir('dist', { recursive: true });
await writeFile(
  'dist/index.html',
  '<!doctype html><html lang="en"><head><meta charset="utf-8"><title>Docker Multi-Stage Build</title></head><body><h1>Hello World from Docker multi-stage build</h1></body></html>\n',
);
