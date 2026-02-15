# 📚 Knowledge Base - Godot Vault

Este diretório contém toda a base de conhecimento acumulada através de pesquisa, experimentação e aprendizado durante o desenvolvimento do Godot Vault.

## Estrutura

```
knowledge/
├── research/          # Pesquisas de estado da arte
├── patterns/          # Padrões de design e arquitetura
└── best-practices/    # Melhores práticas descobertas
```

## 🔍 Research (Pesquisas)

Documentos de pesquisa sobre tópicos específicos antes da implementação.

**Propósito**:
- Estudar estado da arte
- Comparar diferentes abordagens
- Documentar fontes e referências
- Fundamentar decisões técnicas

**Quando Criar**:
- Antes de implementar nova feature
- Ao explorar novo padrão
- Quando há múltiplas alternativas

**Template**: Ver `research/TEMPLATE.md`

**Exemplos Futuros**:
- `game-architectures.md` - Comparação ECS vs Component-based vs outros
- `state-management.md` - FSM vs Behavior Trees vs GOAP
- `input-systems.md` - Padrões de input handling
- `physics-systems.md` - Character controllers e movimento

## 📐 Patterns (Padrões)

Documentação de padrões de design aplicados ao contexto de game development.

**Propósito**:
- Documentar padrões úteis
- Mostrar implementação em GDScript
- Explicar quando usar cada padrão
- Fornecer exemplos práticos

**Quando Criar**:
- Após decidir usar um padrão
- Ao implementar padrão importante
- Para documentar padrão custom

**Exemplos Futuros**:
- `component-pattern.md` - Como criar componentes reutilizáveis
- `observer-pattern.md` - EventBus e signals
- `state-pattern.md` - State machines em prática
- `object-pool.md` - Pooling de objetos para performance

## ✨ Best Practices (Melhores Práticas)

Guias práticos e lições aprendidas sobre tópicos específicos.

**Propósito**:
- Documentar lições aprendidas
- Compartilhar dicas e truques
- Estabelecer convenções
- Evitar erros comuns

**Quando Criar**:
- Após resolver problema complexo
- Ao descobrir abordagem melhor
- Para documentar convenções
- Quando há armadilhas comuns

**Exemplos Futuros**:
- `performance-optimization.md` - Otimizações em Godot
- `debugging-techniques.md` - Como debugar efetivamente
- `godot-quirks.md` - Peculiaridades do Godot
- `input-handling.md` - Boas práticas de input

## Como Contribuir

### Adicionando Pesquisa

1. Crie arquivo em `research/[topico].md`
2. Use template fornecido
3. Inclua fontes e referências
4. Compare diferentes abordagens
5. Conclua com recomendação

### Documentando Padrão

1. Crie arquivo em `patterns/[padrao].md`
2. Explique o padrão
3. Mostre implementação GDScript
4. Forneça exemplos de uso
5. Liste prós e contras

### Compartilhando Best Practice

1. Crie arquivo em `best-practices/[topico].md`
2. Descreva o contexto
3. Explique a abordagem
4. Forneça exemplos
5. Liste gotchas/armadilhas

## Convenções

### Nomenclatura de Arquivos
- Usar kebab-case: `my-topic.md`
- Nomes descritivos e específicos
- Evitar nomes genéricos

### Estrutura de Documento
- Começar com breve resumo
- Incluir data de criação
- Citar fontes
- Usar exemplos de código
- Concluir com takeaways

### Referências
- Sempre citar fontes
- Incluir links quando possível
- Documentar versões (ex: Godot 4.3)
- Atualizar quando informação muda

## Manutenção

Esta base de conhecimento deve ser:
- **Viva**: Atualizada conforme aprendemos
- **Referenciável**: Linkada de DECISIONS.md e código
- **Prática**: Com exemplos reais do projeto
- **Completa**: Cobrindo tanto teoria quanto prática

## Links Úteis

### Documentação Principal
- [PLANNING.md](../PLANNING.md) - Roadmap do projeto
- [DECISIONS.md](../DECISIONS.md) - Decisões arquiteturais
- [ARCHITECTURE.md](../ARCHITECTURE.md) - Arquitetura do sistema

### Recursos Externos
- [Godot Docs](https://docs.godotengine.org/)
- [Game Programming Patterns](https://gameprogrammingpatterns.com/)
- [GDC Vault](https://www.gdcvault.com/)

---

> "Conhecimento não documentado é conhecimento perdido."
