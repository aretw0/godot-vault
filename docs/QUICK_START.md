# 🚀 Quick Start Guide - Godot Vault

## 5 Minutos para Começar

### 1. Abrir o Projeto

1. Abra o Godot Engine 4.3+
2. Clique em "Import"
3. Navegue até a pasta do projeto
4. Selecione `project.godot`

### 2. Executar o Exemplo

1. Pressione F5 ou clique no botão "Play"
2. Você verá a tela de boas-vindas
3. Pressione ESC para testar o EventBus

### 3. Explorar a Estrutura

```
core/
├── autoload/
│   ├── event_bus.gd      ← Sistema de eventos global
│   └── game_manager.gd   ← Gerenciador de estado do jogo
├── state_machine/
│   ├── state_machine.gd  ← Máquina de estados reutilizável
│   └── state.gd          ← Classe base para estados
└── utils/
    └── game_utils.gd     ← Funções utilitárias
```

## Uso Rápido dos Sistemas

### EventBus - Comunicação por Eventos

```gdscript
# Emitir evento
EventBus.emit("player_scored", {"points": 100})

# Escutar evento
func _ready():
    EventBus.on("player_scored", _on_player_scored)

func _on_player_scored(data: Dictionary):
    print("Pontos:", data.points)
```

### StateMachine - Gerenciamento de Estados

```gdscript
# Criar states
var idle_state = State.new()
var walk_state = State.new()

# Configurar state machine
var sm = StateMachine.new()
add_child(sm)
sm.add_state("idle", idle_state)
sm.add_state("walk", walk_state)
sm.set_initial_state("idle")

# Transição
sm.transition_to("walk")
```

### GameManager - Estado Global

```gdscript
# Pausar/Despausar
GameManager.pause_game()
GameManager.resume_game()

# Carregar cena
GameManager.load_scene("res://levels/level_1.tscn")

# Reiniciar
GameManager.restart_scene()
```

### GameUtils - Utilitários

```gdscript
# Smooth lerp
var smooth_pos = GameUtils.smooth_lerp_vec2(
    current_pos, 
    target_pos, 
    5.0,  # velocidade
    delta
)

# Tempo formatado
var time = GameUtils.seconds_to_time_string(elapsed_seconds)
# Retorna: "05:30"

# Ponto aleatório em círculo
var pos = GameUtils.random_point_in_circle(100.0)
```

## Criando Seu Primeiro Componente

### 1. Crie um Script de Componente

`components/health/health_component.gd`:

```gdscript
extends Node
class_name HealthComponent

signal health_changed(current: int, maximum: int)
signal died()

@export var max_health: int = 100

var current_health: int:
    set(value):
        current_health = clamp(value, 0, max_health)
        health_changed.emit(current_health, max_health)
        if current_health <= 0:
            died.emit()

func _ready() -> void:
    current_health = max_health

func take_damage(amount: int) -> void:
    current_health -= amount
    EventBus.emit("damage_taken", {
        "amount": amount,
        "current_health": current_health
    })

func heal(amount: int) -> void:
    current_health += amount
```

### 2. Use em uma Cena

```gdscript
extends CharacterBody2D

@onready var health: HealthComponent = $HealthComponent

func _ready() -> void:
    health.died.connect(_on_died)

func _on_died() -> void:
    queue_free()
```

## Próximos Passos

### Estudar Exemplos
1. Abra `examples/main.tscn`
2. Leia `examples/scenes/main.gd`
3. Execute e experimente

### Criar um Jogo Simples
1. Crie uma nova cena em `examples/`
2. Use os core systems
3. Adicione componentes reutilizáveis

### Expandir o Vault
1. Adicione novos componentes em `components/`
2. Crie utilities em `core/utils/`
3. Documente seu trabalho

## Atalhos Úteis do Godot

- **F5**: Executar projeto
- **F6**: Executar cena atual
- **F7**: Pausar durante execução
- **Ctrl+S**: Salvar
- **Ctrl+Shift+S**: Salvar tudo
- **Ctrl+D**: Duplicar node
- **Ctrl+A**: Adicionar node filho

## Templates Rápidos

### Script de Node Básico
```gdscript
extends Node2D

func _ready() -> void:
    pass

func _process(delta: float) -> void:
    pass
```

### Script de CharacterBody2D
```gdscript
extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(delta: float) -> void:
    # Adicione sua lógica aqui
    move_and_slide()
```

### Estado Customizado
```gdscript
extends State

func enter(data: Dictionary = {}) -> void:
    print("Entrando no estado")

func exit() -> void:
    print("Saindo do estado")

func update(delta: float) -> void:
    # Lógica do frame
    pass

func physics_update(delta: float) -> void:
    # Lógica de física
    pass
```

## Recursos Úteis

- [Documentação Godot](https://docs.godotengine.org/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
- [Godot Tutorials](https://docs.godotengine.org/en/stable/community/tutorials.html)

## Solução de Problemas

### Projeto não abre?
- Verifique se está usando Godot 4.3+
- Reimporte o projeto

### Erros de script?
- Verifique sintaxe do GDScript
- Veja console de erros (F12)

### Autoloads não funcionam?
- Verifique `project.godot`
- Reinicie o Godot

## Dúvidas?

Consulte:
1. [README.md](../README.md) - Visão geral
2. [ARCHITECTURE.md](ARCHITECTURE.md) - Arquitetura
3. [STYLE_GUIDE.md](STYLE_GUIDE.md) - Estilo de código
4. [CONTRIBUTING.md](CONTRIBUTING.md) - Como contribuir

---

**Divirta-se criando! 🎮✨**
