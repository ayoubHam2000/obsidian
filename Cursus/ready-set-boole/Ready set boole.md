
https://chatgpt.com/share/a6715dca-5451-485d-a530-996748a3933d
https://chatgpt.com/share/15f570a6-6a67-4bad-9607-cefbfbf003c3
http://alain.troesch.free.fr/2023/Fichiers/coursMP2I-fondements.pdf
### Boolean Algebra

Boolean algebra is a branch of mathematics that deals with variables that have two distinct values: true (1) and false (0). Named after George Boole, it is fundamental in digital logic design and computer science.

Boolean Algebra
https://www.youtube.com/playlist?list=PLTd6ceoshprcTJdg5AI6i2D2gZR5r8_Aw

![[Screenshot from 2023-12-25 16-14-35.png]]

![[Screenshot from 2024-06-30 20-32-18.png]]

### Karnaugh map 

A Karnaugh map (K-map) is a graphical tool used in digital logic design to simplify Boolean algebra expressions.

### Steps to Use a K-map

1. **Draw the K-map:**
    - For a function with n variables, draw a grid.
    - Label the rows and columns with combinations of variable values in Gray code.
2. **Fill the K-map:**
    - Place the output value (0 or 1)
3. **Group the 1s:**
    - Form groups of 1s in the K-map. Each group should be a rectangle containing 1, 2, 4, 8, etc., cells (power of 2) and should be as large as possible.
    - Groups can wrap around the edges of the K-map.
4. **Write the Simplified Expression:**
    - For each group, write down the product (AND) term that represents the group.
    - Combine these product terms with the sum (OR) to get the simplified Boolean expression.


### Gray code

Gray code, or reflected binary code, is a binary numeral system where two successive values differ in only one bit. It’s commonly used in digital systems to prevent errors during the transition between consecutive values.

gray_code(n) = n ^ (n >> 1)


## Reverse polish form notation

Reverse Polish notation (RPN), also known as postfix notation, is a mathematical notation in which operators follow their operands. This contrasts with the more common infix notation, where operators are placed between operands (e.g., A+B).

A+B+C -> AB+C+ or ABC++

**Evaluation:** RPN expressions are typically evaluated using a stack, where operands are pushed onto the stack, and operators pop the necessary operands from the stack, perform the operation, and push the result back onto the stack.

## Negation normal form and Conjunctive normal form

Negation Normal Form (NNF) and Conjunctive Normal Form (CNF) are ways to standardize logical expressions in Boolean algebra. These forms are useful in various applications, such as simplifying logic circuits, automated theorem proving, and logic programming.

**Definition of NNF**
- Negations is directly applied to variables.
- The expression uses only AND  and OR operators besides NOT.
- ¬(A⋅B)=¬A+¬B
**Definition of CNF**
CNF is a standardized logical expression that is a conjunction (AND) of one or more clauses, where each clause is a disjunction (OR) of literals (variables or their negations).
Example:
$(A1​+B1​+¬C1​)⋅(A2​+¬B2​+C2​)⋅…⋅(An​+Bn​+Cn​)$
## Boolean satisfiability problem

The Boolean satisfiability problem (SAT) is a fundamental problem in computer science and mathematical logic. It involves determining whether there exists an assignment of truth values (true or false) to variables that makes a given Boolean formula true. SAT is the first problem that was proven to be NP-complete

## Sets theory

Set theory is a fundamental branch of mathematics that studies collections of objects, known as sets. It forms the basis for various other fields, including logic, probability, and computer science.

![[CheatSheetS.pdf]]

**Power Set**: The set of all subsets of a set.
**Venn diagrams** visually represent relationships between sets. Circles are used to represent sets, and their overlap shows intersections, while their union encompasses the area covered by all circles.

## Space-filling curves

Space-filling curves are mathematical constructs that map a one-dimensional line into a higher-dimensional space, such as a plane or a volume, in a continuous manner.

**Famous Space-Filling Curves**
- Peano Curve
![[The-first-second-and-third-order-of-a-Peano-curve-and-b-Hilbert-curve-128406488.png|400]]
- Hilbert Curve
![[Hilbert-curve_rounded-gradient-animated.gif]]

## Groups mathematical structure

In mathematics, a **group** is a fundamental algebraic structure that `models symmetry` and operations that combine elements in a consistent way.

Definition:

A **group** is a set G equipped with a binary operation ⋅ (often referred to as multiplication, but can also be addition, composition, etc.) that combines two elements of G to form another element of G. The set and operation must satisfy four key properties:
![[Screenshot from 2024-07-03 14-20-58.png]]

## Morphisms

In mathematics, **morphisms** are a generalization of functions or mappings that preserve structure in various contexts.
A **morphism** is a mapping between two objects that preserves the structure defined on those objects

**injective surjective bijective**

![[th-3444714506.jpeg]]

