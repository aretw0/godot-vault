# Componentes Reutilizáveis

Este diretório contém componentes modulares e reutilizáveis que podem ser adicionados a qualquer node para adicionar funcionalidade.

## Componentes Disponíveis

### Health Component
**Arquivo**: `health/health_component.gd`

Gerencia saúde de entidades.

**Uso**:
```gdscript
@onready var health: HealthComponent = $HealthComponent

func _ready():
    health.died.connect(_on_died)
    health.take_damage(20)

func _on_died():
    queue_free()
```

**Exports**:
- `max_health`: Vida máxima
- `start_at_max`: Começar com vida cheia
- `can_revive`: Permitir reviver após morte

**Sinais**:
- `health_changed(current, maximum)`: Vida mudou
- `died()`: Entidade morreu
- `damage_taken(amount)`: Dano recebido
- `healed(amount)`: Cura recebida

### Follow Camera
**Arquivo**: `camera/follow_camera.gd`

Câmera que segue suavemente um alvo.

**Uso**:
```gdscript
var camera = FollowCamera.new()
add_child(camera)
camera.target = player
camera.follow_speed = 5.0
```

**Exports**:
- `target`: Node para seguir
- `follow_speed`: Velocidade de seguimento
- `offset_from_target`: Offset da câmera
- `use_limits`: Usar limites de câmera

**Métodos**:
- `shake(amount)`: Tremor de câmera
- `set_target(new_target)`: Define novo alvo

### Health Bar (UI)
**Arquivo**: `ui/health_bar.gd`

Barra de vida visual para UI.

**Uso**:
```gdscript
# Em uma cena com estrutura:
# Control (UIHealthBar script)
#   ├─ Background (ColorRect)
#   └─ Background/Fill (ColorRect)

health_bar.health_component = $"../HealthComponent"
```

**Exports**:
- `health_component`: Referência ao HealthComponent
- `fill_color`: Cor quando saudável
- `low_health_color`: Cor quando vida baixa
- `smooth_transition`: Transição suave

## Como Criar Novos Componentes

### 1. Estrutura Básica

```gdscript
extends Node
class_name MeuComponente
## Breve descrição do componente

signal evento_importante()

@export_group("Configurações")
@export var parametro: int = 10

var estado_interno: bool = false

func _ready() -> void:
    pass

## Método público principal
func fazer_algo() -> void:
    pass
```

### 2. Princípios

- **Independente**: Não dependa de estruturas específicas de cena
- **Configurável**: Use @export para parametrização
- **Comunicativo**: Use sinais para comunicação
- **Documentado**: Documente com comentários ##
- **Testável**: Mantenha lógica separada de apresentação

### 3. Organização

```
components/
├── categoria/
│   ├── componente_a.gd
│   ├── componente_b.gd
│   └── README.md
```

### 4. Template Base

```gdscript
extends Node
class_name NomeComponente
## Descrição de uma linha
##
## Descrição mais detalhada explicando:
## - O que o componente faz
## - Como usar
## - Quando usar

signal exemplo_signal(data: Dictionary)

@export_group("Grupo 1")
@export var config_1: int = 10

var _private_var: bool = false

func _ready() -> void:
    # Inicialização
    pass

## Método público bem documentado
func metodo_publico(param: String) -> void:
    pass

func _metodo_privado() -> void:
    pass
```

## Exemplos de Uso

### Composição de Componentes

```gdscript
# Player.gd
extends CharacterBody2D

@onready var health: HealthComponent = $HealthComponent
@onready var camera: FollowCamera = $FollowCamera

func _ready():
    health.died.connect(_on_player_died)
    camera.target = self

func _on_player_died():
    # Game over logic
    GameManager.pause_game()
```

### Sistema de Eventos

```gdscript
# Em qualquer componente
func _ready():
    EventBus.on("game_started", _on_game_started)

func _on_game_started(data: Dictionary):
    # Reagir ao evento
    pass
```

## Boas Práticas

1. **Nome Descritivo**: Use nomes que descrevam claramente a função
2. **Responsabilidade Única**: Um componente = uma responsabilidade
3. **Expose Configuração**: Use @export para flexibilidade
4. **Sinais para Comunicação**: Prefira sinais a chamadas diretas
5. **Documente Tudo**: Comentários claros salvam tempo depois
6. **Teste Isoladamente**: Componentes devem funcionar sozinhos

## Contribuindo

Ao adicionar novos componentes:

1. Siga a estrutura de pastas
2. Documente adequadamente
3. Adicione exemplos de uso
4. Atualize este README
5. Considere criar cena de exemplo em `examples/`
