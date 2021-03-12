.PHONY: up down clean

up:
	vagrant up

down:
	vagrant down

clean:
	vagrant destroy -f

