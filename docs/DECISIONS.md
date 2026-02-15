# 🎯 DECISIONS - Architectural Decision Records

## Sobre Este Documento

Este documento registra **Decisões Arquiteturais** (ADRs - Architectural Decision Records) tomadas durante o desenvolvimento do Godot Vault. Cada decisão documenta o contexto, alternativas consideradas, e a escolha final com suas justificativas.

## Formato de Decisão

Cada decisão segue este template:

```markdown
### ADR-XXX: Título da Decisão

**Data**: YYYY-MM-DD
**Status**: [Proposta | Aceita | Rejeitada | Obsoleta | Superseded by ADR-YYY]
**Contexto**: Qual problema estamos resolvendo?
**Decisão**: O que decidimos fazer?
**Consequências**: Impactos positivos e negativos
**Alternativas Consideradas**: Outras opções avaliadas
```

---

## Decisões Arquiteturais

### ADR-001: Escolha da Engine - Godot 4.3

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**: 
Necessidade de escolher uma game engine para o projeto de aprendizado e experimentação. Considerações importantes incluem curva de aprendizado, licenciamento, comunidade, e capacidades técnicas.

**Decisão**: 
Utilizar Godot Engine 4.3+ como engine base do projeto.

**Razões**:
1. **Open Source**: Licença MIT permite uso livre e aprendizado do código fonte
2. **GDScript**: Linguagem própria otimizada para game development, fácil de aprender
3. **Godot 4.x**: Nova versão com melhorias significativas (rendering, physics, scripting)
4. **Comunidade Ativa**: Grande comunidade, documentação extensa, recursos de aprendizado
5. **Multiplataforma**: Suporte nativo para múltiplas plataformas
6. **Scene System**: Sistema de cenas facilita composição e reuso
7. **Editor Integrado**: Editor robusto com debugging integrado

**Consequências**:
- ✅ Sem custos de licenciamento
- ✅ Código fonte disponível para estudo
- ✅ Boa documentação e tutoriais
- ✅ Sistema de nodes facilita componentes reutilizáveis
- ⚠️ Ecossistema menor que Unity/Unreal (mas crescendo)
- ⚠️ Godot 4 é relativamente novo (menor histórico de projetos)

**Alternativas Consideradas**:
- **Unity**: Mais popular, mas licenciamento complexo e runtime fee recente
- **Unreal**: Mais poderoso, mas complexidade muito alta para aprendizado
- **Bevy (Rust)**: Interessante mas curva de aprendizado muito íngreme

---

### ADR-002: Arquitetura Baseada em Componentes

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**:
Necessidade de definir padrão arquitetural para organização de código e entidades de jogo. Objetivo é maximizar reusabilidade e composição.

**Decisão**:
Adotar arquitetura baseada em componentes (Component-based Architecture) ao invés de herança profunda ou ECS puro.

**Razões**:
1. **Composição sobre Herança**: Facilita reuso sem hierarquias complexas
2. **Alinhamento com Godot**: Node system do Godot é naturalmente component-based
3. **Flexibilidade**: Componentes podem ser adicionados/removidos dinamicamente
4. **Testabilidade**: Componentes isolados são mais fáceis de testar
5. **Aprendizado**: Padrão comum na indústria, bom para estudo

**Implementação**:
```gdscript
# Entidade = Node com componentes anexados
Player (CharacterBody2D)
  ├─ HealthComponent
  ├─ MovementComponent
  ├─ InputComponent
  └─ AnimationComponent
```

**Consequências**:
- ✅ Código altamente reutilizável
- ✅ Fácil de estender funcionalidade
- ✅ Testabilidade melhorada
- ✅ Documentação clara de responsabilidades
- ⚠️ Overhead de comunicação entre componentes (resolvido via sinais)
- ⚠️ Necessita disciplina para evitar componentes "god"

**Alternativas Consideradas**:
- **Herança Profunda**: Rejeitada por criar acoplamento e dificultar reuso
- **ECS Puro**: Muito complexo para o objetivo de aprendizado, não natural no Godot
- **Data-Oriented Design**: Interessante mas conflita com paradigma do Godot

---

### ADR-003: Sistema de Eventos Global (EventBus)

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**:
Componentes e sistemas precisam se comunicar sem criar acoplamento direto. Necessidade de broadcast de eventos game-wide.

**Decisão**:
Implementar padrão EventBus como singleton (autoload) para comunicação global desacoplada.

**Implementação**:
```gdscript
# Autoload: EventBus
EventBus.emit("player_died", {"score": score})
EventBus.on("player_died", _on_player_died)
```

**Razões**:
1. **Desacoplamento**: Emissores não conhecem receptores
2. **Flexibilidade**: Listeners podem ser adicionados/removidos dinamicamente
3. **Observable Pattern**: Padrão bem estabelecido
4. **Godot-friendly**: Complementa sistema de sinais nativo

**Consequências**:
- ✅ Baixo acoplamento entre sistemas
- ✅ Fácil adicionar novos listeners
- ✅ Broadcast eficiente para eventos globais
- ⚠️ Pode ser overused, criando dependências implícitas
- ⚠️ Debug pode ser mais difícil (fluxo não óbvio)
- ⚠️ Necessita convenção de nomes de eventos

**Boas Práticas Estabelecidas**:
- Usar para eventos verdadeiramente globais
- Preferir sinais diretos quando relação é clara
- Documentar eventos disponíveis
- Namespace para evitar colisões (ex: "player:died", "ui:opened")

**Alternativas Consideradas**:
- **Sinais Diretos**: Ótimo para relações claras, mas cria acoplamento
- **Service Locator**: Mais complexo, necessita registro de serviços
- **Message Queue**: Overhead desnecessário para uso atual

---

### ADR-004: Tipagem Estática em GDScript

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**:
GDScript suporta tanto tipagem dinâmica quanto estática. Necessidade de escolher convenção para o projeto.

**Decisão**:
Utilizar tipagem estática em todo o código do projeto.

**Implementação**:
```gdscript
# Sempre especificar tipos
var health: int = 100
func take_damage(amount: int) -> void:
    health -= amount
```

**Razões**:
1. **Detecção Precoce de Erros**: Erros de tipo detectados em tempo de edição
2. **Performance**: GDScript otimiza código com tipos estáticos
3. **Documentação**: Tipos servem como documentação
4. **IDE Support**: Melhor autocomplete e refactoring
5. **Manutenibilidade**: Mais fácil entender código com tipos explícitos

**Consequências**:
- ✅ Menos bugs em runtime
- ✅ Melhor performance
- ✅ Código mais legível
- ✅ Refactoring mais seguro
- ⚠️ Verbosidade ligeiramente maior
- ⚠️ Menos flexibilidade (mas isso é bom)

**Alternativas Consideradas**:
- **Tipagem Dinâmica**: Mais flexível mas propensa a erros
- **Tipagem Mista**: Inconsistente, não recomendado

---

### ADR-005: Organização de Diretórios por Categoria

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**:
Necessidade de estrutura clara de diretórios que escale com crescimento do projeto.

**Decisão**:
Organizar código por categoria/tipo ao invés de por feature.

**Estrutura**:
```
core/         # Sistemas fundamentais
components/   # Componentes reutilizáveis
examples/     # Cenas de demonstração
addons/       # Plugins do editor
docs/         # Documentação
```

**Razões**:
1. **Reusabilidade**: Componentes centralizados são fáceis de encontrar
2. **Separação de Concerns**: Core vs específico de jogo
3. **Godot Convention**: Alinhado com estrutura comum em projetos Godot
4. **Escalabilidade**: Fácil adicionar novas categorias

**Consequências**:
- ✅ Componentes fáceis de encontrar e reutilizar
- ✅ Clara separação entre reusável e específico
- ✅ Facilita extração de componentes para outros projetos
- ⚠️ Features podem estar espalhadas (mitigado com boa documentação)

**Alternativas Consideradas**:
- **Por Feature**: Agrupa código relacionado, mas dificulta reuso
- **Flat Structure**: Simples mas não escala

---

### ADR-006: Documentation-First Approach

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**:
Projeto focado em aprendizado necessita documentação extensiva. Necessidade de estabelecer cultura de documentação.

**Decisão**:
Adotar abordagem "documentation-first" onde pesquisa e documentação precedem implementação.

**Processo**:
1. Pesquisar estado da arte → `docs/knowledge/research/`
2. Documentar padrões → `docs/knowledge/patterns/`
3. Decidir abordagem → `DECISIONS.md`
4. Implementar → `core/` ou `components/`
5. Documentar uso → `docs/knowledge/best-practices/`

**Razões**:
1. **Aprendizado**: Documentar consolida conhecimento
2. **Qualidade**: Pesquisa evita reinventar roda mal
3. **Reuso**: Conhecimento documentado é reutilizável
4. **Onboarding**: Novos contribuidores têm contexto
5. **Decisões Informadas**: Decisões baseadas em pesquisa

**Consequências**:
- ✅ Decisões mais informadas
- ✅ Conhecimento preservado
- ✅ Melhor código (baseado em padrões)
- ✅ Facilita contribuições futuras
- ⚠️ Overhead de tempo inicial (mas economiza depois)

---

### ADR-007: Estrutura de Gestão de Conhecimento

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**:
Projeto terá muita documentação de pesquisa. Necessidade de organização clara para gerenciamento de conhecimento.

**Decisão**:
Criar estrutura dedicada para gestão de conhecimento em `docs/knowledge/`:

```
docs/knowledge/
├── research/          # Pesquisas de estado da arte
├── patterns/          # Padrões de design documentados
└── best-practices/    # Melhores práticas descobertas
```

**Razões**:
1. **Organização**: Conhecimento categorizado é mais útil
2. **Descoberta**: Fácil encontrar pesquisas anteriores
3. **Reuso**: Evita pesquisar o mesmo tópico duas vezes
4. **Crescimento**: Estrutura escala com projeto

**Consequências**:
- ✅ Conhecimento bem organizado
- ✅ Fácil referência futura
- ✅ Evita duplicação de pesquisa
- ✅ Base para decisões futuras

---

### ADR-008: CI/CD com GDScript Toolkit

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**:
Necessidade de garantir qualidade de código através de linting e testes automatizados. Projeto precisa de feedback rápido sobre problemas de código tanto localmente quanto no CI.

**Decisão**:
Implementar CI/CD mínimo usando GitHub Actions com GDScript Toolkit (gdlint) para linting.

**Ferramentas Escolhidas**:
1. **gdlint** (gdtoolkit 4.3.1): Linter oficial para GDScript
2. **gdformat**: Formatador automático de código
3. **GUT** (futuro): Framework de testes unitários para Godot

**Implementação**:
```bash
# Workflow GitHub Actions
.github/workflows/ci.yml
  - Lint GDScript files
  - Run tests (quando implementados)
  - Validate project structure

# Scripts locais
scripts/lint.sh      # Executar lint
scripts/format.sh    # Auto-formatar
scripts/test.sh      # Executar testes
```

**Razões**:
1. **gdtoolkit**: Ferramenta oficial e bem mantida para GDScript
2. **Compatibilidade**: Versão 4.3.1 alinhada com Godot 4.3
3. **Automação**: Scripts locais + GitHub Actions
4. **Qualidade**: Detecta problemas antes do merge
5. **Velocidade**: Feedback rápido (lint ~10s)

**Consequências**:
- ✅ Qualidade de código garantida
- ✅ PRs automaticamente validados
- ✅ Desenvolvimento local com feedback imediato
- ✅ Formatação consistente em todo código
- ⚠️ Necessita Python instalado localmente
- ⚠️ Adiciona etapa no workflow (mas rápida)

**Boas Práticas Estabelecidas**:
- Executar `./scripts/lint.sh` antes de commit
- Usar `./scripts/format.sh` para auto-correção
- CI bloqueia merge se lint falhar
- Todos arquivos `.gd` devem passar no lint

**Alternativas Consideradas**:
- **Sem CI**: Rejeitado, qualidade inconsistente
- **Apenas testes manuais**: Não escala
- **Outras ferramentas de lint**: gdtoolkit é padrão da comunidade

---

### ADR-009: Cache do Godot Binary no CI

**Data**: 2026-02-15
**Status**: Aceita

**Contexto**:
O workflow de CI estava baixando o binário do Godot (107 MB) em cada execução, resultando em:
- Tempo de setup longo (~30 segundos)
- Uso desnecessário de bandwidth
- Dependência de serviços externos (GitHub releases)
- Maior consumo de recursos

**Decisão**:
Implementar cache do binário do Godot usando GitHub Actions Cache (`actions/cache@v4`).

**Implementação**:
```yaml
- name: Cache Godot binary
  id: cache-godot
  uses: actions/cache@v4
  with:
    path: Godot_v4.3-stable_linux.x86_64
    key: godot-4.3-stable-linux-x86_64
    restore-keys: godot-4.3-stable-
```

**Razões**:
1. **Performance**: Reduz tempo de setup de ~30s para ~5s
2. **Eficiência**: Evita download repetido do mesmo binário
3. **Confiabilidade**: Menos dependência de disponibilidade de releases.github.com
4. **Custo**: Reduz uso de bandwidth e minutos de Actions
5. **Sustentabilidade**: Menor consumo de recursos e energia

**Consequências**:
- ✅ CI mais rápido e eficiente
- ✅ Menor latência em execuções subsequentes
- ✅ Melhor experiência do desenvolvedor
- ✅ Uso de recurso nativo do GitHub Actions
- ⚠️ Cache expira após 7 dias sem uso
- ⚠️ Primeira execução após invalidação ainda é lenta
- ⚠️ Cache ocupa espaço (limite de 10GB por repositório)

**Detalhes Técnicos**:
- **Cache Key**: `godot-4.3-stable-linux-x86_64` (específica para versão)
- **Tamanho**: ~107 MB (binário comprimido no cache)
- **Validade**: 7 dias de inatividade ou até mudança de versão
- **Fallback**: Download automático em cache miss

**Boas Práticas Estabelecidas**:
- Usar chave de cache específica por versão
- Incluir plataforma na chave (linux-x86_64)
- Usar `cp` ao invés de `mv` para preservar arquivo em cache
- Limpar arquivo zip após extração para economizar espaço

**Alternativas Consideradas**:
- **Sem cache**: Descartado, muito ineficiente
- **Cache do zip**: Considerado mas cache do binário é mais direto
- **Docker image**: Mais complexo, overhead de container desnecessário
- **Self-hosted runner**: Custo alto, complexidade de manutenção

---

## Templates para Novas Decisões

### Template: Nova Decisão

```markdown
### ADR-XXX: [Título]

**Data**: YYYY-MM-DD
**Status**: Proposta

**Contexto**: 
[Descreva o problema ou situação]

**Decisão**: 
[O que foi decidido]

**Razões**:
1. [Razão 1]
2. [Razão 2]
...

**Consequências**:
- ✅ [Positivo]
- ⚠️ [Negativo/Trade-off]

**Alternativas Consideradas**:
- **[Opção A]**: [Por que não]
- **[Opção B]**: [Por que não]
```

## Processo de Decisão

1. **Identificar Necessidade**: Quando uma decisão arquitetural é necessária?
2. **Pesquisar**: Estudar estado da arte e padrões existentes
3. **Propor**: Criar ADR com status "Proposta"
4. **Discutir**: Revisar alternativas e trade-offs
5. **Decidir**: Atualizar status para "Aceita" ou "Rejeitada"
6. **Implementar**: Seguir decisão na implementação
7. **Revisar**: Periodicamente revisar decisões antigas

## Índice de Decisões

| ADR | Título | Status | Data |
|-----|--------|--------|------|
| 001 | Escolha da Engine - Godot 4.3 | Aceita | 2026-02-15 |
| 002 | Arquitetura Baseada em Componentes | Aceita | 2026-02-15 |
| 003 | Sistema de Eventos Global (EventBus) | Aceita | 2026-02-15 |
| 004 | Tipagem Estática em GDScript | Aceita | 2026-02-15 |
| 005 | Organização de Diretórios por Categoria | Aceita | 2026-02-15 |
| 006 | Documentation-First Approach | Aceita | 2026-02-15 |
| 007 | Estrutura de Gestão de Conhecimento | Aceita | 2026-02-15 |
| 008 | CI/CD com GDScript Toolkit | Aceita | 2026-02-15 |
| 009 | Cache do Godot Binary no CI | Aceita | 2026-02-15 |

---

**Última Atualização**: 2026-02-15

> "Uma decisão bem documentada hoje economiza horas de debate amanhã."
