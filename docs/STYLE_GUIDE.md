# Guia de Estilo - Godot Vault

## Filosofia

O código deve ser:
- **Legível**: Outros desenvolvedores devem entender facilmente
- **Consistente**: Seguir sempre os mesmos padrões
- **Simples**: Soluções diretas são preferíveis a soluções complexas
- **Documentado**: Código público deve ter documentação clara

## Convenções GDScript

### Nomenclatura

```gdscript
# Classes: PascalCase
class_name PlayerController

# Funções e métodos: snake_case
func calculate_damage(base: int, multiplier: float) -> int:
    return int(base * multiplier)

# Variáveis: snake_case
var player_health: int = 100
var is_jumping: bool = false

# Variáveis privadas: prefixo _
var _internal_state: String = ""

# Constantes: SCREAMING_SNAKE_CASE
const MAX_SPEED: float = 400.0
const JUMP_VELOCITY: float = -300.0

# Enums: PascalCase para nome, SCREAMING_SNAKE_CASE para valores
enum State {
    IDLE,
    WALKING,
    JUMPING,
    FALLING
}

# Sinais: snake_case
signal health_changed(new_health: int)
signal player_died()
```

### Tipagem Estática

Sempre use tipagem estática quando possível:

```gdscript
# ✅ Bom
var speed: float = 100.0
func get_position() -> Vector2:
    return position

# ❌ Evite
var speed = 100.0
func get_position():
    return position
```

### Ordem de Declaração

Organize o código nesta ordem:

```gdscript
class_name MyClass
extends Node2D

# 1. Documentação da classe
## Breve descrição da classe
## Pode ter múltiplas linhas

# 2. Sinais
signal something_happened()
signal value_changed(new_value: int)

# 3. Enums
enum State { IDLE, ACTIVE }

# 4. Constantes
const MAX_HEALTH: int = 100

# 5. Variáveis exportadas
@export var speed: float = 200.0
@export var damage: int = 10

# 6. Variáveis públicas
var current_health: int = MAX_HEALTH

# 7. Variáveis privadas
var _is_initialized: bool = false

# 8. Onready variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer

# 9. Métodos virtuais do Godot (_ready, _process, etc)
func _ready() -> void:
    _initialize()

func _process(delta: float) -> void:
    _update_logic(delta)

# 10. Métodos públicos
func take_damage(amount: int) -> void:
    current_health -= amount

# 11. Métodos privados
func _initialize() -> void:
    pass

func _update_logic(delta: float) -> void:
    pass
```

### Comentários e Documentação

```gdscript
## Documentação de classe usando ##
## Explica o propósito e uso da classe
class_name ExampleClass

## Documentação de função usando ##
## 
## Parâmetros:
##   value: O valor a ser processado
##   
## Retorna:
##   O valor processado
func process_value(value: int) -> int:
    # Comentários inline usando #
    # Explicam detalhes de implementação
    var result = value * 2
    return result
```

### Espaçamento e Formatação

```gdscript
# Linhas em branco para separar seções lógicas
func complex_function() -> void:
    # Seção 1: Inicialização
    var data = []
    var count = 0
    
    # Seção 2: Processamento
    for item in items:
        process(item)
        count += 1
    
    # Seção 3: Finalização
    emit_signal("processing_complete", count)

# Espaços ao redor de operadores
var result = (a + b) * c
var is_valid = x > 0 and y < 100

# Sem espaço antes de :, espaço depois
func example(param: int) -> void:
    pass

# Quebra de linha para parâmetros longos
func long_function(
    first_param: String,
    second_param: int,
    third_param: bool
) -> void:
    pass
```

### Condicionais e Loops

```gdscript
# Prefira early returns
func validate_input(value: int) -> bool:
    if value < 0:
        return false
    if value > 100:
        return false
    return true

# Use match para múltiplas condições
func handle_state(state: State) -> void:
    match state:
        State.IDLE:
            handle_idle()
        State.WALKING:
            handle_walking()
        State.JUMPING:
            handle_jumping()

# Loops claros e simples
for i in range(10):
    process(i)

for item in items:
    if item.is_valid():
        item.process()
```

### Sinais e Callbacks

```gdscript
# Nomeie callbacks com prefixo _on_
signal button_pressed()

func _ready() -> void:
    button_pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
    print("Button was pressed!")

# Para sinais de outros nós, inclua o nome do nó
func _on_timer_timeout() -> void:
    pass

func _on_player_health_changed(new_health: int) -> void:
    pass
```

### Exports e Configuração

```gdscript
# Agrupe exports relacionados
@export_group("Movement")
@export var speed: float = 200.0
@export var acceleration: float = 500.0

@export_group("Combat")
@export var damage: int = 10
@export var attack_range: float = 50.0

# Use ranges para validação
@export_range(0, 100) var health: int = 100
@export_range(0.0, 1.0) var volume: float = 1.0
```

## Padrões Específicos do Godot

### Nodes e Cenas

```gdscript
# Use @onready para nodes
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

# Valide nodes antes de usar
func _ready() -> void:
    if sprite == null:
        push_error("Sprite node not found!")
        return
```

### Recursos (Resources)

```gdscript
# Prefira Resources para dados
class_name WeaponData
extends Resource

@export var damage: int = 10
@export var fire_rate: float = 0.5
@export var ammo: int = 30
```

### Autoloads

```gdscript
# Autoloads devem ser estáticos quando possível
# e fornecer APIs claras
extends Node

func do_something() -> void:
    pass

# Uso:
# EventBus.do_something()
```

## Anti-Padrões a Evitar

```gdscript
# ❌ Não use get_node() quando @onready serve
var sprite = get_node("Sprite2D")

# ✅ Use @onready
@onready var sprite: Sprite2D = $Sprite2D

# ❌ Não acesse diretamente nodes de outras cenas
get_parent().get_node("OtherNode").do_something()

# ✅ Use sinais para comunicação
signal action_requested()
action_requested.emit()

# ❌ Não abuse de autoloads para tudo
Globals.player_position = position
Globals.player_health = health
Globals.player_score = score

# ✅ Use sistemas específicos ou componentes
EventBus.emit("player_moved", position)
health_component.update(health)
```

## Checklist de Código

Antes de commitar, verifique:

- [ ] Código segue convenções de nomenclatura
- [ ] Tipagem estática está aplicada
- [ ] Código está documentado
- [ ] Sem warnings do Godot
- [ ] Sem código comentado/não usado
- [ ] Variáveis têm nomes descritivos
- [ ] Funções têm responsabilidade única
- [ ] Código está formatado consistentemente

## Ferramentas

- **GDScript Toolkit**: Formatter e linter
  ```bash
  gdformat arquivo.gd
  gdlint arquivo.gd
  ```

## Referências

- [Godot GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [GDScript Best Practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/index.html)
