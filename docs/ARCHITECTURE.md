# Arquitetura do Godot Vault

## Visão Geral

O Godot Vault foi projetado com foco em modularidade, reusabilidade e composabilidade. A arquitetura segue princípios de design que facilitam a manutenção e extensão do código.

## Princípios Arquiteturais

### 1. Separação de Responsabilidades
Cada sistema tem uma responsabilidade bem definida:
- **EventBus**: Comunicação entre sistemas
- **GameManager**: Estado global do jogo
- **StateMachine**: Gerenciamento de estados
- **Components**: Comportamentos específicos e reutilizáveis

### 2. Baixo Acoplamento
Sistemas se comunicam através de interfaces bem definidas (eventos, sinais) ao invés de referências diretas.

### 3. Alta Coesão
Funcionalidades relacionadas são agrupadas em módulos específicos.

### 4. Composição sobre Herança
Preferimos compor comportamentos através de componentes ao invés de hierarquias de herança profundas.

## Camadas da Arquitetura

```
┌─────────────────────────────────────┐
│         Game Specific Code          │  ← Seu jogo/projeto
├─────────────────────────────────────┤
│      Reusable Components            │  ← components/
├─────────────────────────────────────┤
│         Core Systems                │  ← core/
├─────────────────────────────────────┤
│         Godot Engine                │
└─────────────────────────────────────┘
```

### Camada 1: Core Systems
Sistemas fundamentais que fornecem funcionalidades base:
- Autoloads (EventBus, GameManager)
- State Machine
- Utilities

**Características**:
- Sem dependências de game-specific
- Altamente reutilizáveis
- Bem documentados e testados

### Camada 2: Reusable Components
Componentes modulares que implementam comportamentos comuns:
- Sistema de câmera
- Controles de jogador
- UI components

**Características**:
- Usam core systems
- Podem ser compostos
- Configuráveis via exported variables

### Camada 3: Game Specific
Código específico do seu jogo/projeto:
- Lógica de gameplay
- Níveis
- Assets específicos

## Padrões de Design Utilizados

### Singleton Pattern (Autoloads)
Usado para sistemas que precisam ser acessíveis globalmente:
```gdscript
# EventBus, GameManager são autoloads
EventBus.emit("event_name", data)
GameManager.pause_game()
```

### Observer Pattern (Event System)
Permite comunicação desacoplada entre sistemas:
```gdscript
# Publisher
EventBus.emit("enemy_spawned", enemy)

# Subscriber
EventBus.on("enemy_spawned", _on_enemy_spawned)
```

### State Pattern (State Machine)
Gerencia comportamentos complexos baseados em estados:
```gdscript
state_machine.transition_to("attacking")
```

### Component Pattern
Comportamentos são adicionados via composição:
```gdscript
# Em vez de herança profunda:
player.add_child(health_component)
player.add_child(movement_component)
```

## Fluxo de Comunicação

```
User Input → Input Handler → EventBus → Game Systems → Update Scene
                                ↓
                          GameManager ← State Changes
```

## Convenções de Nomenclatura

- **Classes**: PascalCase (`StateMachine`, `GameUtils`)
- **Arquivos**: snake_case (`state_machine.gd`, `game_utils.gd`)
- **Funções**: snake_case (`transition_to()`, `pause_game()`)
- **Variáveis privadas**: prefixo `_` (`_current_state`, `_listeners`)
- **Constantes**: SCREAMING_SNAKE_CASE (`MAX_HEALTH`, `JUMP_FORCE`)

## Diretrizes de Extensão

### Adicionando Novos Core Systems
1. Crie em `core/` com responsabilidade clara
2. Documente com comentários `##`
3. Considere se deve ser autoload
4. Mantenha sem dependências de game-specific

### Criando Componentes Reutilizáveis
1. Adicione em `components/`
2. Use composition sobre inheritance
3. Exponha configurações via `@export`
4. Documente uso com exemplos

### Implementando Features Específicas
1. Use os core systems
2. Componha com reusable components
3. Mantenha separado do código reutilizável
4. Documente decisões de design

## Exemplo de Fluxo Completo

```gdscript
# 1. Core System (EventBus)
EventBus.emit("player_health_changed", {"health": 50})

# 2. Component (HealthBar) escuta o evento
func _ready():
    EventBus.on("player_health_changed", _update_health_bar)

func _update_health_bar(data):
    health_bar.value = data.health

# 3. Game Manager coordena estado global
GameManager.current_state = GameManager.GameState.PLAYING
```

## Boas Práticas

1. **Mantenha sistemas independentes**: Um sistema não deve conhecer detalhes internos de outro
2. **Use eventos para comunicação**: Prefira EventBus a referências diretas
3. **Documente públicas APIs**: Todo método público deve ter comentário
4. **Teste incrementalmente**: Teste cada sistema isoladamente
5. **Favoreça clareza**: Código legível > código "esperto"

## Próximos Passos

- Adicionar sistema de recursos (Resource-based data)
- Implementar pooling de objetos
- Criar sistema de configurações
- Adicionar sistema de salvamento/carregamento
