# Scripts de Desenvolvimento

Scripts utilitários para desenvolvimento local do godot-vault.

## Scripts Disponíveis

### 🔍 lint.sh

Executa o linter GDScript em todos os arquivos do projeto.

```bash
./scripts/lint.sh
```

**Saída**:
- Lista todos arquivos verificados
- Mostra erros encontrados
- Resumo final com contagem
- Exit code 0 se passou, 1 se falhou

**Quando usar**: Antes de commit

### 🔧 format.sh

Formata automaticamente todos os arquivos GDScript.

```bash
./scripts/format.sh
```

**O que corrige**:
- Trailing whitespace
- Indentação
- Espaçamento de operadores
- Quebras de linha

**Quando usar**: Quando lint falhar por formatação

### 🧪 test.sh

Executa testes unitários usando GUT.

```bash
./scripts/test.sh
```

**Requer**:
- Godot 4.3+ no PATH
- Addon GUT instalado (futuro)
- Pasta `test/` com arquivos de teste

**Quando usar**: Antes de push

## Pré-requisitos

### Python e gdtoolkit

```bash
# Instalar Python 3.11+
python3 --version

# Instalar gdtoolkit
pip install gdtoolkit==4.3.1
```

### Godot (para testes)

```bash
# Baixar Godot 4.3
# https://godotengine.org/download

# Adicionar ao PATH ou criar alias
alias godot='/caminho/para/Godot'
```

## Workflow Recomendado

```bash
# 1. Fazer mudanças
vim core/novo_sistema.gd

# 2. Formatar
./scripts/format.sh

# 3. Verificar lint
./scripts/lint.sh

# 4. Testar (quando implementado)
./scripts/test.sh

# 5. Commit
git commit -am "feat: adiciona novo sistema"
```

## Integração com Git Hooks

Para executar automaticamente antes de commit:

```bash
# Criar .git/hooks/pre-commit
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
./scripts/lint.sh || {
    echo "❌ Lint failed. Run './scripts/format.sh' to fix."
    exit 1
}
EOF

chmod +x .git/hooks/pre-commit
```

## Troubleshooting

**Comando não encontrado**:
```bash
chmod +x scripts/*.sh
```

**gdlint não encontrado**:
```bash
pip install --user gdtoolkit==4.3.1
export PATH="$HOME/.local/bin:$PATH"
```

**Godot não encontrado**:
```bash
# Adicionar ao ~/.bashrc ou ~/.zshrc
export PATH="/caminho/para/godot:$PATH"
```

## Mais Informações

Veja [CI_CD.md](../docs/CI_CD.md) para documentação completa sobre CI/CD.
