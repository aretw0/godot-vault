# CI/CD - Integração e Deploy Contínuo

## Visão Geral

O godot-vault utiliza GitHub Actions para CI/CD mínimo, focando em **qualidade de código** através de linting e testes automatizados.

## Ferramentas Utilizadas

### GDScript Toolkit (gdtoolkit)

Conjunto de ferramentas para análise e formatação de código GDScript:

- **gdlint**: Linter que verifica estilo de código e possíveis problemas
- **gdformat**: Formatador automático de código GDScript

Versão utilizada: `4.3.1` (compatível com Godot 4.3)

### GUT (Godot Unit Test)

Framework de testes unitários para Godot (planejado para futuro).

## Workflows do GitHub Actions

### Workflow Principal: `.github/workflows/ci.yml`

Executado automaticamente em:
- Push para branches `main` e `develop`
- Pull requests para `main` e `develop`
- Manualmente via `workflow_dispatch`

#### Jobs:

1. **Lint GDScript** 🔍
   - Instala gdtoolkit
   - Verifica todos arquivos `.gd` com gdlint
   - Verifica formatação com gdformat
   - Falha se encontrar erros de linting

2. **Run Tests** 🧪
   - Baixa Godot 4.3 headless
   - Importa o projeto
   - Executa testes com GUT (se existirem)
   - Atualmente pula testes se pasta `test/` não existir

3. **Validate Project** ✅
   - Verifica existência de `project.godot`
   - Valida estrutura de diretórios
   - Verifica `.gitignore`

## Scripts Locais

### 1. Lint Local

```bash
./scripts/lint.sh
```

**O que faz**:
- Instala/atualiza gdtoolkit
- Executa gdlint em todos arquivos `.gd`
- Exibe resumo de erros
- Retorna exit code 0 se passou, 1 se falhou

**Uso recomendado**: Antes de commit

### 2. Formatação Automática

```bash
./scripts/format.sh
```

**O que faz**:
- Instala/atualiza gdtoolkit
- Formata automaticamente todos arquivos `.gd`
- Corrige trailing whitespace, indentação, etc.

**Uso recomendado**: Quando o lint falhar por problemas de formatação

### 3. Testes Local

```bash
./scripts/test.sh
```

**O que faz**:
- Verifica se Godot está instalado
- Verifica se pasta `test/` existe
- Executa testes com GUT
- Atualmente apenas avisa se não houver testes

**Uso recomendado**: Antes de push

## Regras de Linting

O gdlint verifica:

### ✅ Obrigatório Passar

1. **Trailing Whitespace**: Sem espaços no final das linhas
2. **Class Definition Order**: `class_name` antes de `extends`
3. **Variable Order**: Ordem correta (exports → vars → @onready)
4. **Indentação**: Tabs/spaces consistentes
5. **Line Length**: Máximo 100 caracteres (warning)
6. **Naming Conventions**: snake_case para funções/variáveis

### ⚠️ Warnings (não bloqueiam)

- Linhas muito longas (>100 caracteres)
- Complexidade ciclomática alta
- Funções muito grandes

## Configuração GDLint

Atualmente usa configuração padrão. Para customizar, criar `.gdlintrc`:

```ini
[tool.gdlint]
max-line-length = 120
# outras configurações...
```

## Como Executar Localmente

### Pré-requisitos

```bash
# Instalar Python 3.11+
python3 --version

# Instalar gdtoolkit
pip install gdtoolkit==4.3.1

# Para testes (futuro): Instalar Godot 4.3
# Adicionar Godot ao PATH ou criar alias
alias godot='/caminho/para/Godot'
```

### Workflow de Desenvolvimento

```bash
# 1. Fazer mudanças no código
vim core/meu_sistema.gd

# 2. Formatar código
./scripts/format.sh

# 3. Verificar lint
./scripts/lint.sh

# 4. Executar testes (quando implementados)
./scripts/test.sh

# 5. Commit se tudo passou
git add .
git commit -m "feat: adiciona novo sistema"

# 6. Push (CI vai rodar automaticamente)
git push
```

## Adicionando Testes (Futuro)

Para adicionar testes unitários:

### 1. Instalar GUT

```bash
# Baixar GUT do GitHub
# https://github.com/bitwes/Gut/releases

# Extrair para addons/gut/
```

### 2. Criar Testes

```gdscript
# test/test_event_bus.gd
extends GutTest

func test_emit_and_receive():
    var received = false
    var callback = func(): received = true
    
    EventBus.on("test_event", callback)
    EventBus.emit("test_event")
    
    assert_true(received, "Event should be received")
```

### 3. Executar

```bash
./scripts/test.sh
# ou
godot --headless -s addons/gut/gut_cmdln.gd
```

## Integração com IDE

### VS Code

Instalar extensão: **godot-tools**

```json
// .vscode/settings.json
{
    "gdscript.format.enabled": true,
    "gdscript.linter.enabled": true
}
```

### Configurar como pre-commit hook

```bash
# .git/hooks/pre-commit
#!/bin/bash
./scripts/lint.sh || exit 1
```

## Troubleshooting

### Lint falha localmente mas passa no CI

```bash
# Atualizar gdtoolkit
pip install --upgrade gdtoolkit==4.3.1
```

### Godot não encontrado

```bash
# Adicionar ao PATH ou criar alias
export PATH="/caminho/para/godot:$PATH"
# ou
alias godot='/caminho/para/Godot_v4.3-stable_linux_x86_64'
```

### Erro de formatação

```bash
# Auto-corrigir
./scripts/format.sh

# Verificar novamente
./scripts/lint.sh
```

## Métricas de Qualidade

O CI garante:

- ✅ **100% dos arquivos GDScript lintados**
- ✅ **Formatação consistente**
- ✅ **Estrutura de projeto válida**
- 🔜 **Testes passando** (quando implementados)

## Próximos Passos

- [ ] Adicionar GUT e criar primeiros testes
- [ ] Adicionar code coverage
- [ ] Adicionar análise de complexidade
- [ ] Adicionar check de performance
- [ ] Integrar com pre-commit hooks

## Referências

- [GDScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit)
- [GUT - Godot Unit Test](https://github.com/bitwes/Gut)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Godot CI/CD Best Practices](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_dedicated_servers.html)

---

**Última Atualização**: 2026-02-15
