/*
На вход программы поступает последовательность целых чисел.
Определить НОД для соседних элементов. Например:
Вход: 21 7 10 5 15
Выход:
	(21, 7) = 7
	(7, 10) = 1
	(10, 5) = 5
	(5, 15) = 5
Указание:
	Для вычисления НОД можно использовать любой из рассмотренных ранее алгоритмов.
*/

#include<stdio.h>

int main()
{
	int a=0;
	printf("Введите количество элементов: ");
	scanf("%d", &a);
	int Mas[a], i;
	for(i=0; i<a; i++)
	{
		printf("Введите %d элемент: ", i+1);
		scanf("%d", &Mas[i]);
	}

	int n=0, n1=0, b=0;
	for (i=0; i<a-1; i++)
	{
		n = Mas[i];
		n1 = Mas[i+1];
		if (n1 > n)
		{
			b = n;
			n = n1;
			n1 = b;
		}
		int t1;
		while (n1%n!=0)
		{
			t1 = n1 % n;
			n1 = n;
			n = t1;
		}
		printf("\tНОД чисел %d и %d : %d\n", Mas[i], Mas[i+1], n);
	}
	return 0;
}
