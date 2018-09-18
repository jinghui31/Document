# Java
```java
abstract class Animal {
	protected String name = '';

	public Animal(String name) {
		this.name = name;
	}

	public Animal() {
		this('No-Name');
	}

	protected int shout_num = 3;

	public int getShoutNum() {
		return shout_num;
	}

	public void setShoutNum(int num) {
		if (num < 0) throw new java.lang.IllegalArgumentException();
		shout_num = num;
	}

	public String shout() {
		String result = '';
		for (int i = 0; i < shout_num; i++) {
			result += getShoutSound() + '';
		}
		return 'My name is ' + name + '.' + result;
	}

	abstract protected String getShoutSound();
}

class Cat extends Animal {
	protected String getShoutSound() {
		return 'meow~';
	}
}

class Dog extends Animal {
	protected String getShoutSound() {
		return 'woof';
	}
}

public class ShoutGame {
	public static void main(String[] args) {
		Animal[] = arrayAnimal = new Animal[3];
		// polymorphism
		arrayAnimal[0] = new Cat('May');
		arrayAnimal[1] = new Dog('Linda');
		arrayAnimal[2] = new Cat('Joy');
		for (Animal animal: arrayAnimal) {
			System.out.println(animal.shout());
		}
	}
}
```

```java
interface IFly {
	public String flyTo (String place);
}

class FlyingCat extends Cat implements IFly {
	public String flyTo (String place) {
		return shout() + " I'm going to fly to " + place + ".";
	}
}

public class Test {
	public static void main(String[] args) {
		FlyingCat cat = new FlyingCat('May');
		System.out.println(cat.flyTo('Taiwan'));
	}
}
```

# Python
```py
import abc
class Animal(abc.ABC):
	def __init__(self, name = 'No-Name'):
		self._name = name
		self._shout_num = 3

	@property
	def shout_num(self):
		return self._shout_num

	@shout_num.setter
	def shout_num(self, num):
		if num < 0: raise ValueError()
		self._shout_num = num
	
	def shout(self):
		result = ''
		for _ in range(self.__shout_num):
			result += self._getShoutSound() + ''
		return 'My name is ' + self.__name + '.' + result
	
	@abc.abstractmechod
	def _getShoutSound(self):
		pass

class Cat(Animal):
	def _getShoutSound(self):
		return 'meow'

class Dog(Animal):
	def _getShoutSound(self):
		return 'woof'

if __name__ == '__main__':
	cat = Cat('May')
	cat.shout_num = 5
	print(cat.shout())
```

```py
import abc
class IFly(abc.ABC):
	@abc.abstractmethod
	def flyTo(self, place):
		pass

class FlyingCat(Cat, IFly):
	def flyTo(self, place):
		return self.shout() + " I'm going to fly to " + place + "."

if __name__ = "__main__":
	cat = FlyingCat('May')
	print(cat.flyTo('Taiwan'))
```
# Encapsulation
```py
import sys

class Calculation:
	def __init__(self, nums):
		self.__nums = nums
		for num in self.__nums:
			self.__checkPositiveInteger(num)
	
	def __checkPositvieInteger(self, num):
		if (not isinstance(num, int)) or (num < = 0):
			raise ValueError('invalid positive integer: ' + str(num))

	def __primeFactorize(self, num):
		prime_factorize = dict()
		i = 2
		while(num > 1):
			if num % i == 0:
				prime_factorize[i] = prime_factorize.get(i, 0) + 1
				num /= i
			else:
				i += 1
		return prime_factorize
	
	def findGCF(self):
		prime_factorize = list()
		for num in self.__nums:
			prime_factorize.append(self.__primeFactorize(num))
		
		common_prime = set(prime_factorize[0].keys())
		for pf in prime_factorize[1:]:
			common_prime &= set(pf.keys())
		
		gcf = 1
		for prime in common_prime:
			m = sys.maxsize
			for pf in prime_factorize:
				m = min(m, pf[prime])
			gcf = gcf * (prime ** m)
		return gcf
	
	def finLCM(self):
		gcf = self.findGCF()
		lcm = gcf
		for num in self.__nums:
			lcm *= int(num/gcf)
		return lcm
```