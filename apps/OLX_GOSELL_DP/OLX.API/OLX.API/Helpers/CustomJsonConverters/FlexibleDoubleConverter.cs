using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace OLX.API.Helpers.CustomJsonConverters
{
    public class FlexibleDoubleConverter : JsonConverter<double>
    {
        public override double Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            if (reader.TokenType == JsonTokenType.String)
            {
                var stringValue = reader.GetString();
                if (stringValue != null)
                {
                    stringValue = stringValue.Replace(',', '.');
                    if (double.TryParse(stringValue, NumberStyles.Any, CultureInfo.InvariantCulture, out var result))
                    {
                        return result;
                    }
                }
                throw new JsonException($"Invalid double value: {stringValue}");
            }
            if (reader.TokenType == JsonTokenType.Number)
            {
                return reader.GetDouble();
            }
            throw new JsonException("Expected a string or number for double.");
        }

        public override void Write(Utf8JsonWriter writer, double value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value.ToString(CultureInfo.InvariantCulture));
        }
    }
}
