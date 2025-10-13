{...}: {
  # Global snippets (UltiSnips-style JSON for multiple languages)
  # Added comprehensive TS/React/Hono/Tailwind/full‑stack helpers.
  xdg.configFile."nvim/snippets/global.json".text = builtins.toJSON {
    # ---------- General / TS ----------
    log = { prefix = "log"; body = ["console.log($1);"]; description = "Log output to console"; };
    "arrow function" = { prefix = "af"; body = ["const $1 = ($2) => {" "  $3" "}"]; description = "Arrow function"; };
    "async function" = { prefix = "asf"; body = ["async function $1($2): Promise<$3> {" "  $4" "}"]; description = "Async function"; };
    "typed arrow" = { prefix = "taf"; body = ["const $1 = ($2: $3): $4 => {" "  $5" "}"]; description = "Typed arrow function"; };
    "result type" = { prefix = "rt"; body = ["type Result<T, E = Error> = {" "  ok: true;" "  value: T;" "} | {" "  ok: false;" "  error: E;" "};"]; description = "Result union type"; };
    "exhaustive switch" = { prefix = "esw"; body = ["switch ($1) {" "  case $2: { $3; break; }" "  default: {" "    const _exhaustive: never = $1;" "    return _exhaustive;" "  }" "}"]; description = "Exhaustive switch with never"; };
    "typed fetch" = { prefix = "tfetch"; body = [
      "async function $1<T>(input: RequestInfo, init?: RequestInit & { schema?: z.ZodSchema<T> }): Promise<T> {",
      "  const res = await fetch(input, init);",
      "  if (!res.ok) throw new Error(`HTTP ${res.status}`);",
      "  const data = await res.json();",
      "  if (init?.schema) return init.schema.parse(data);",
      "  return data as T;",
      "}"], description = "Typed fetch helper with optional Zod"; };
    
    # ---------- React ----------
    "react component" = { prefix = "rc"; description = "React functional component"; body = [
      "import React from 'react';",
      "type ${1:ComponentName}Props = { $2 };",
      "export function ${1:ComponentName}({ $3 }: ${1:ComponentName}Props) {",
      "  return (",
      "    <div className=\"$4\">$5</div>",
      "  );",
      "}" ]; };
    "react arrow component" = { prefix = "rac"; body = [
      "import React from 'react';",
      "type ${1:ComponentName}Props = { $2 };",
      "export const ${1:ComponentName}: React.FC<${1:ComponentName}Props> = ({ $3 }) => {",
      "  return <div className=\"$4\">$5</div>;",
      "};",
      "export default ${1:ComponentName};" ]; description = "React FC arrow"; };
    "use state" = { prefix = "us"; body = ["const [${1:state}, set${2:State}] = React.useState<${3:type}>($4);"]; description = "useState hook"; };
    "use effect" = { prefix = "ue"; body = ["React.useEffect(() => {", "  $1", "  return () => { $2 };", "}, [$3]);"]; description = "useEffect skeleton"; };
    "use memo" = { prefix = "um"; body = ["const $1 = React.useMemo(() => $2, [$3]);"]; description = "useMemo"; };
    "use callback" = { prefix = "ucb"; body = ["const $1 = React.useCallback(($2) => { $3 }, [$4]);"]; description = "useCallback"; };
    "react context" = { prefix = "rctx"; body = [
      "interface ${1:Ctx}Value { $2 }",
      "const ${1:Ctx}Context = React.createContext<${1:Ctx}Value | undefined>(undefined);",
      "export function ${1:Ctx}Provider({ children }: { children: React.ReactNode }) {",
      "  const value: ${1:Ctx}Value = { $3 };",
      "  return <${1:Ctx}Context.Provider value={value}>{children}</${1:Ctx}Context.Provider>;",
      "}",
      "export function use${1:Ctx}() {",
      "  const ctx = React.useContext(${1:Ctx}Context);",
      "  if (!ctx) throw new Error('use${1:Ctx} must be used within ${1:Ctx}Provider');",
      "  return ctx;",
      "}" ]; description = "React context + hook"; };
    "react suspense boundary" = { prefix = "rsb"; body = [
      "const ${1:Boundary} = ({ children }: { children: React.ReactNode }) => (",
      "  <React.Suspense fallback={${2:<div>Loading...</div>}}>",
      "    {children}",
      "  </React.Suspense>",
      ");",
      "export default ${1:Boundary};" ]; description = "Suspense boundary"; };
    "react error boundary" = { prefix = "reb"; body = [
      "class ${1:ErrorBoundary} extends React.Component<{ children: React.ReactNode }, { hasError: boolean }> {",
      "  state = { hasError: false };",
      "  static getDerivedStateFromError() { return { hasError: true }; }",
      "  componentDidCatch(error: unknown, info: unknown) { console.error(error, info); }",
      "  render() {",
      "    if (this.state.hasError) return ${2:<div>Something went wrong</div>};",
      "    return this.props.children;",
      "  }",
      "}",
      "export default ${1:ErrorBoundary};" ]; description = "React error boundary"; };

    # ---------- Hono (Cloudflare/Edge) ----------
    "hono basic" = { prefix = "happ"; body = [
      "import { Hono } from 'hono';",
      "const app = new Hono<{ Bindings: ${1:EnvBindings} }>();",
      "app.get('/', (c) => c.text('OK'));",
      "export default app;" ]; description = "Hono basic app"; };
    "hono route group" = { prefix = "hrg"; body = [
      "import { Hono } from 'hono';",
      "export const ${1:users} = new Hono();",
      "${1:users}.get('/', (c) => c.json([$2]));",
      "${1:users}.post('/', async (c) => {",
      "  const body = await c.req.json();",
      "  return c.json(body, 201);",
      "});" ]; description = "Hono route group"; };
    "hono validator" = { prefix = "hval"; body = [
      "import { z } from 'zod';",
      "import { zValidator } from '@hono/zod-validator';",
      "const schema = z.object({ ${1:name}: z.string() });",
      "app.post('/${2:path}', zValidator('json', schema), (c) => {",
      "  const data = c.req.valid('json');",
      "  return c.json(data);",
      "});" ]; description = "Hono route with Zod validator"; };
    "hono error handler" = { prefix = "herr"; body = [
      "app.onError((err, c) => {",
      "  console.error(err);",
      "  return c.json({ error: err.message }, 500);",
      "});" ]; description = "Hono global error handler"; };

    # ---------- Zod / Validation ----------
    "zod schema" = { prefix = "zschema"; body = [
      "import { z } from 'zod';",
      "export const ${1:Name}Schema = z.object({",
      "  ${2:field}: z.${3:string}(),",
      "});",
      "export type ${1:Name} = z.infer<typeof ${1:Name}Schema>;" ]; description = "Zod object schema"; };
    "zod enum" = { prefix = "zenum"; body = ["export const ${1:EnumName} = [${2:'A','B'}] as const;", "export type ${1:EnumName} = typeof ${1:EnumName}[number];"]; description = "Const enum array"; };

    # ---------- Tailwind UI ----------
    "tw button" = { prefix = "twbtn"; body = [
      "<button className=\"inline-flex items-center justify-center rounded-md bg-blue-600 px-4 py-2 text-sm font-medium text-white shadow hover:bg-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-400 disabled:opacity-50 disabled:pointer-events-none\">$1</button>" ]; description = "Tailwind button"; };
    "tw card" = { prefix = "twcard"; body = [
      "<div className=\"rounded-lg border bg-white shadow-sm dark:bg-neutral-900 dark:border-neutral-800 p-4\">",
      "  <h3 className=\"text-lg font-semibold mb-2\">$1</h3>",
      "  <p className=\"text-sm text-neutral-600 dark:text-neutral-400\">$2</p>",
      "</div>" ]; description = "Tailwind card"; };
    "tw flex center" = { prefix = "twfc"; body = ["<div className=\"flex items-center justify-center $1\">$2</div>"]; description = "Flexbox center"; };
    "tw grid responsive" = { prefix = "twgrid"; body = ["<div className=\"grid gap-4 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 $1\">$2</div>"]; description = "Responsive grid"; };
    "tw container" = { prefix = "twcon"; body = ["<div className=\"mx-auto w-full max-w-7xl px-4 md:px-8 $1\">$2</div>"]; description = "Container wrapper"; };

    # ---------- Fullstack (Prisma / tRPC optional) ----------
    "prisma model" = { prefix = "pmodel"; body = [
      "model ${1:Model} {",
      "  id        String   @id @default(cuid())",
      "  createdAt DateTime @default(now())",
      "  updatedAt DateTime @updatedAt",
      "  ${2:name} String",
      "}" ]; description = "Prisma model skeleton"; };
    "trpc router" = { prefix = "trouter"; body = [
      "import { z } from 'zod';",
      "import { router, publicProcedure } from '../trpc';",
      "export const ${1:app}Router = router({",
      "  ${2:getItem}: publicProcedure.input(z.object({ id: z.string() })).query(async ({ ctx, input }) => {",
      "    return ctx.db.$3.findUnique({ where: { id: input.id } });",
      "  }),",
      "});",
      "export type ${1:app}Router = typeof ${1:app}Router;" ]; description = "tRPC router skeleton"; };
    "service class" = { prefix = "svc"; body = [
      "export class ${1:Name}Service {",
      "  constructor(private readonly deps: { $2 }) {}",
      "  async ${3:method}(${4:args}): Promise<${5:void}> {",
      "    $6",
      "  }",
      "}" ]; description = "Service class skeleton"; };
  };
}
