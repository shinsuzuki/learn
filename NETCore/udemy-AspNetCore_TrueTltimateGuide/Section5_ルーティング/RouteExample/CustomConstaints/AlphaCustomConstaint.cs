using System.Text.RegularExpressions;

namespace RouteExample.CustomConstaints
{
    public class AlphaCustomConstaint : IRouteConstraint
    {
        public bool Match(
            HttpContext? httpContext,
            IRouter? route,
            string routeKey,
            RouteValueDictionary values,
            RouteDirection routeDirection
        )
        {
            if (!values.TryGetValue(routeKey, out var value))
            {
                return false;
            }

            if (value == null)
            {
                return false;
            }

            var valueString = value.ToString()!;
            Regex regex = new Regex("^[a-zA-Z]+$");
            return regex.IsMatch(valueString);
        }
    }
}
