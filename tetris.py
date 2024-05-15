import pygame
import random

# Define constants
WIDTH, HEIGHT = 300, 600
BLOCK_SIZE = 30
ROWS, COLS = HEIGHT // BLOCK_SIZE, WIDTH // BLOCK_SIZE
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
SHAPES = [
    [[1, 1, 1],
     [0, 1, 0]],
    [[0, 2, 2],
     [2, 2, 0]],
    [[3, 3, 0],
     [0, 3, 3]],
    [[4, 0, 0],
     [4, 4, 4]],
    [[0, 0, 5],
     [5, 5, 5]],
    [[6, 6, 6, 6]],
    [[7, 7],
     [7, 7]]
]

# Initialize Pygame
pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Tetris")

# Define classes
class Block:
    def __init__(self, shape, x, y):
        self.shape = shape
        self.x = x
        self.y = y

    def draw(self):
        for i in range(len(self.shape)):
            for j in range(len(self.shape[i])):
                if self.shape[i][j] != 0:
                    pygame.draw.rect(screen, COLORS[self.shape[i][j]], (self.x * BLOCK_SIZE + j * BLOCK_SIZE, self.y * BLOCK_SIZE + i * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE))
                    pygame.draw.rect(screen, BLACK, (self.x * BLOCK_SIZE + j * BLOCK_SIZE, self.y * BLOCK_SIZE + i * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE), 2)

    def move(self, dx, dy):
        self.x += dx
        self.y += dy

    def rotate(self):
        self.shape = list(zip(*self.shape[::-1]))

def create_block():
    shape = random.choice(SHAPES)
    return Block(shape, COLS // 2 - len(shape[0]) // 2, 0)

def draw_grid():
    for i in range(ROWS):
        pygame.draw.line(screen, BLACK, (0, i * BLOCK_SIZE), (WIDTH, i * BLOCK_SIZE))
    for j in range(COLS):
        pygame.draw.line(screen, BLACK, (j * BLOCK_SIZE, 0), (j * BLOCK_SIZE, HEIGHT))

# Main game loop
clock = pygame.time.Clock()
game_over = False
current_block = create_block()
next_block = create_block()

COLORS = [(0, 0, 0), (255, 0, 0), (0, 255, 0), (0, 0, 255), (255, 255, 0), (255, 0, 255), (0, 255, 255), (128, 128, 128)]

while not game_over:
    screen.fill(WHITE)
    draw_grid()

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            game_over = True
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_LEFT:
                current_block.move(-1, 0)
            if event.key == pygame.K_RIGHT:
                current_block.move(1, 0)
            if event.key == pygame.K_DOWN:
                current_block.move(0, 1)
            if event.key == pygame.K_UP:
                current_block.rotate()

    # Move the current block down automatically
    if pygame.time.get_ticks() % 500 == 0:
        if current_block.y + len(current_block.shape) < ROWS:
            current_block.move(0, 1)
        else:
            current_block = next_block
            next_block = create_block()

    # Check for collisions
    for i in range(len(current_block.shape)):
        for j in range(len(current_block.shape[i])):
            if current_block.shape[i][j] != 0:
                if current_block.y + i >= ROWS or current_block.x + j < 0 or current_block.x + j >= COLS or grid[current_block.y + i][current_block.x + j] != 0:
                    game_over = True

    # Draw current and next blocks
    current_block.draw()
    next_block.draw()

    pygame.display.flip()
    clock.tick(30)

pygame.quit()
