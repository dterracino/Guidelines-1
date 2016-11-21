
/// <summary>
/// Do not do this.
/// </summary>
public static class ObjectUtilities
{
    public static string ToStringLower(object obj)
    {
        return obj.ToString.Lower();
    }
}

/// <summary>
/// Do this instead.
/// </summary>
public static class ObjectExtensions
{
    public static string ToStringLower(this object obj)
    {
        return obj.ToString.Lower();
    }
}

public static class Example
{
    public void Main()
    {
        var obj = new object();

        // Instead of this
        var result1 = ObjectUtilities.ToStringLower(obj);

        // Do this
        var result2 = obj.ToStringLower();
    }
}