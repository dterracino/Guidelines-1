# C\# Guidelines

These guidelines are for C\# code and are intended to be used and usable in nearly any project and circumstance.
In cases where any one rule does not apply or cannot be implemented make best efforts to implements all others regardless.

 1.  Inject all dependencies into each class via the constructor. Do not inject dependencies via properties or fields.
 2.  Where possible prefer interface types over concrete classes for argument and member definitions.
 3.  Prefer the `var` keyword over specific types where possible.
 4.  String Concatenation
     * When concatenating 2 strings use the `+` operator.
     * When concatenating a fixed number of strings above 2 use `string.Join` or `string.Format` whichever is more appropriate.
     * When concatenating a dynamic number of strings use `string.Join` or an instance of `StringBuilder` whichever is more appropriate.
 5.  One object definition (class interface, enum, etc.) per file. Do not nest object definitions.
 6.  Name files with the same name as the object defined in the file.
     * Generic classes may be defined in files that exclude the portion of the generic definition.
       Ex: A class such as `ListNode<T>` may be defined in ListNode\`1.cs or ListNode.cs.
       If there are generic and non-generic version of the class such as `ListNode` and `ListNode<T>` the generic version must be defined in a file that includes the generic definition such as ListNode.cs and ListNode\`1.cs respectively.
 7.  Files must be kept in a folder structure that matches the namespace hierarchy.
 8.  Always use curly braces to define the body of a `using`, `if`, `else`, `do`/`while`, `for`, or `while` statement even if it is only one line.
     Exception: Simple `return`/`break`/`continue` statements may be placed directly after an `if` on the same line.
     Note that throw statements are intentionally excluded from this list when they include constructing a new exception.
     When simply re-throwing the current exception - ie. `throw;` with no `new Exception(...)` - the throw statement may be on the same line as an if statement.
 9.  All public or protected members of all classes, all members of interfaces, and all enum values should be documented with [XML style documentation comments](http://msdn.microsoft.com/en-us/library/aa288481\(v=vs.71\).aspx).
     * When documenting override methods you may simply place `<see />` directives referencing the base class' method and describe the reason for the override or the implementation difference, rather than reproduce the base method's documentation entirely.
     * Properties or methods that implement an interface may omit documentation if said documentation would not differ from that in the interface.
 10. Do not write properties with no `get`. Properties should always be able to retrieve their value. If you need to send some data into a class and don't expect to be able to get it back create a method to do it.
 11. No class should have the same name as any namespace and vice-versa.
 12. Use method overloads instead of optional parameters in all cases except when writing methods for COM inter-op.
     * Optional parameters were originally excluded from C\# intentionally then later added as a compromise to ease compatibility with COM inter-op.
       Also the way the compiler resolves references to functions with optional parameters can cause both runtime and/or compile time errors.
       [See Phil Haak's article on this.](http://haacked.com/archive/2010/08/10/versioning-issues-with-optional-arguments.aspx/)
       But what makes it all so much worse is that the official specification for .NET [allows compilers to ignore the values that are assigned to these parameters](https://msdn.microsoft.com/en-us/library/ms182135.aspx)
       Technically speaking any future version of MSBuild could simply stop respecting default parameters.
       Probably not likely to happen but even the slight possibility is terrifying!
 13. Finalizers (destructors) are discouraged, do not use them unless it is required to ensure disposal of items such as unmanaged resources.
 14. Names:
     * Object, struct, enum, and method names should be **UpperCamelCase**.
     * Interface names should be **UpperCamelCase** and begin with the upper case letter **I**.
     * Properties and fields should be named according to their accessibility.
       - Public and protected properties and fields should be **UpperCamelCase**.
       - Private properties and fields should be **lowerCamelCase** and prefixed with an underscore (**_**).
       - Constants and `readonly static` Fields should be **UpperCamelCase**.
     * Arguments and variables should be **lowerCamelCase**.
     * Do not embed type information in variable, property, or field names such as in [Hungarian notation](https://en.wikipedia.org/wiki/Hungarian_notation).
 15. Classes that contain extension methods should have the same name as the class they extend followed by the word "Extensions". Ex: `StringExtensions`.
     * To comply with this rule methods that extend different classes should be defined in different classes (and therefore different files).
     * Methods that extend interfaces should be defined in a class that does not include the leading 'I' of the interface name. Ex: `EnumerableExtensions`.
 16. Carefully order the members of each class by type, then access, then static-ness, then read/write ability.
     * Member order:
       - Constants
       - Fields
       - Properties
       - Indexers
       - Events
       - Delegates
       - Constructors
       - Finalizers (discouraged per rule 14, but if they're necessary put them here)
       - Methods
       - Enums (nested enums disallowed per rule 6, but if they're necessary put them here)
       - Structs (nested structs disallowed per rule 6, but if they're necessary put them here)
       - Interfaces (nested interfaces disallowed per rule 6, but if they're necessary put them here)
       - Classes (nested classes disallowed per rule 6, but if they're necessary put them here)
     * Within each member type order by access:
       - `public`
       - `internal`
       - `protected internal`
       - `protected`
       - `private`
     * Within each access type put `static` members first:
       - `static`
       - instance (non-`static`)
     * Within the static/instance group put `readonly` first:
       - `readonly`
       - writable (non-`readonly`)

## C\# - Models

These guidelines are specific for classes or projects that implement data models, view models, or any other class who's primary purpose is data storage/serialization rather than processing.
They are intended to be in addition to the general rules above.

 1.  Models should be simple classes with properties that store data. Logic should not be implemented on models.
     * Logic that would otherwise be implemented in functions on the model can be implemented via extension methods.
 2.  Models should have a single id that is a `public readonly` field or a property with a `private` setter.
     * When it is necessary to set the id of the model it should only be publicly possible via a constructor.
     * Model classes should implement proper `Equals` and `GetHashCode` overrides based on the value of the id property.
 3.  Use enums instead of using strings, numbers, or objects for status and type fields.
 4.  Collection properties on models should not be publicly settable. The constructor should initialize the collection to the correct instance then consumers can use the add/remove methods to modify the collection instance.

### C\# - Models (NHibernate)

These are model rules specific to NHibernate data models.

 1.  NHiberante models should generally map all unordered collections to ISet instead of IList.
 2.  Any properties should be map-able directly to something in the db - any computed properties should be accessible through functions named like "Get...()"

### C\# - Models (Mongo)

These are model rules specific to Mongo data models.

 1.  Mongo models should have a property of type `IDictionary<string, object>` (often called ExtraElements) with a non-public setter, initialized to a new dictionary in the constructor.

## C\# - Controllers

Rules for .NET MVC controller classes.

 1.  All public methods must return some form of ActionResult or be marked with [NonAction]
 2.  Smaller is better! When in doubt make separate controllers. A controller with a single action method is totally fine.
 3.  Action methods that receive posted data from any javascript should have exactly one parameter: a model type which encapsulates all the parameters for that action as json.

## C\# - `IDisposable` Objects

Rules for any object which implements `IDisposable` or any code which uses such objects.

 1.  Any object or function that creates an `IDisposable` is responsible for calling `Dispose()` on it (unless it is the function's return value in which case the calling function is responsible).
     * When a function is returning an `IDisposable` object the object should be declared but not initialized outside a `try...catch` statement then initialized inside the `try...catch`. If the function encounters an error the disposable object should be disposed of (if it is not null) before the function re-throws the error.

        ```
        public IDisposable GetDisposable() {
            IDisposable disposable = null;
            try {
               ...
               disposable = new Disposable();
               ...
               return disposable;
            } catch {
                if (disposable != null) {
                    disposable.Dispose();
                }
                throw;
            }
        }    
        ```
 2.  Any object which contains members that are IDisposable must also implement `IDisposable` and call `Dispose()` on its members when its `Dispose()` is called.
 3.  Use `using(...) {...}` blocks whenever possible. Refactoring code to allow using `using` is perfectly acceptable.
