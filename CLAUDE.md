# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Visão geral

`IMendes4D` é um **package Delphi** (`IMendes4D.dpk`, sem `.dpr`/executável) que abstrai a
integração com a API tributária IMendes. Ele é consumido como dependência por outros
projetos Delphi (via Boss ou referência direta ao `.dpk`/`.dcp`).

- Compilador/target: Delphi (ProjectVersion 19.1), plataforma `Win32`, `FrameworkType=None`
  (sem VCL/FMX — é uma lib pura de integração HTTP/JSON).
- Gerenciador de dependências: [Boss](https://github.com/HashLoad/boss) (`boss.json`). Dependências
  ficam em `modules/` (ignorado pelo git — não versionado).
- Dependência externa relevante: `modules/log` (unit `GravarLog.pas`) — grava logs de
  requisição/resposta em disco quando `{$IFDEF DEBUG}`.

## Build

Não há scripts de build/lint/test no repositório. Compilação é feita via IDE Delphi ou MSBuild:

```powershell
msbuild IMendes4D.dproj /t:Build /p:Config=Debug /p:Platform=Win32
```

Não há suíte de testes automatizados neste repositório.

## Arquitetura

Todo o código público é exposto via **interfaces**, com implementações `TInterfacedObject`
que seguem um padrão consistente em todo o projeto:

- Construtor público `Create` sempre lança exceção ("Para obter uma instância, utilize a
  função New") — a única forma correta de instanciar é via `class function New`, que chama
  um construtor privado (`CreatePrivate`).
- Fluent/builder interfaces: métodos retornam `Self` (ou a própria interface) para
  encadeamento, e terminam em `&End`, que retorna ao objeto pai (`FParent`, geralmente
  `[weak]` para evitar ciclo de referência).

### Ponto de entrada

`TIMendes4D` (`src/IMendes4D.pas`, interface `iIMendes4D`) é a raiz do fluent API:

```pascal
IMendes4D.New
  .Auth.URL('...').User('...').Password('...').End
  .Resources.POST(REGRASFISCAIS).Body(entity).Content
```

- `Auth` → `iAuthenticator<T>` (`src/Auth/`): guarda URL/usuário/senha genéricos por tipo `T`.
- `Entity` → `iEntity` (`src/Model/IMendes4D.Model.Entity.pas`): monta o payload JSON.
- `Resources` → `iIMendesAPI` (`src/HttpClient/IMendes4D.HttpClient.IMendesAPI.pas`): envia
  o payload via HTTP, injetando `login`/`senha` como headers a partir do `Auth`.

### Camada HTTP

- `iHttpClient` / `THttpClient` (`src/HttpClient/IMendes4D.HttpClient.RestHttpClient.pas`):
  wrapper de baixo nível sobre `REST.Client` (Delphi RTL). Sempre usa `POST`, `Content-Type:
  application/json`, TLS 1.2/1.3. Em `{$IFDEF DEBUG}`, grava request/response via
  `TGravarLog` (módulo `modules/log`).
- `iIMendesAPI` / `TIMendesAPI`: camada de alto nível que conhece os endpoints do domínio
  (`TEndpointBaseType` em `src/IMendes4D.Types.pas`: `REGRASFISCAIS`,
  `ENVIARECEBEDADOS`) e serializa `iEntity.AsJson` como corpo da requisição.

### Camada de Model/DTO

`iEntity` (`src/Model/IMendes4D.Model.Interfaces.pas`) é a raiz para montar o JSON enviado à
API. Cada DTO em `src/Model/DTO/` implementa uma seção do payload como um builder fluente
que escreve diretamente em um `TJSONObject` compartilhado com o pai, adicionando seu par
(`FJsonPair.AddPair(...)`) no método `&End`:

- `iEntity.RegrasFiscais` → `iModelRegrasFiscaisDTO` → agrega `Cabecalho`, `UFs`, `Produtos`
  (cada um genérico em `T`, permitindo encadear de volta ao pai correto).
- `iEntity.EnviaRecebeDados` → `iModelEnviaRecebeDadosDTO<T>` → agrega `HistoricoAcesso`,
  `ProdutosAlterados`, `RemoveDevolvidos` (que por sua vez agrega
  `RemoveDevolvidosProdutos`).

Ao adicionar um novo campo/DTO, siga o padrão existente: construtor privado recebendo o
`Parent` e o `TJSONObject` do pai, `FJson := TJSONObject.Create` próprio, métodos que fazem
`FJson.AddPair(...)` e retornam `Self`, e `&End` que faz `FParent.FJsonPair.AddPair(<nome>,
FJson)` antes de retornar `FParent`. Os nomes das chaves JSON (ex.: `'cnpj'`, `'crt'`,
`'regimeTrib'`) devem corresponder exatamente ao contrato da API IMendes — não inferir nomes
sem confirmar o contrato real.

### Convenções de nomenclatura

- Units seguem `IMendes4D.<Área>.<Nome>.pas` (ex.: `IMendes4D.Model.DTO.Cabecalho.pas`).
- Interfaces prefixadas com `i` minúsculo (`iEntity`, `iHttpClient`), classes com `T`
  (`TEntity`, `THttpClient`).
- Mensagens de exceção e comentários no idioma português.
