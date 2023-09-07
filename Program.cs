using System;
using System.Net;
using System.Threading;

namespace YourNamespace
{
    class Program
    {
        static void Main(string[] args)
        {
            var listener = new HttpListener();
            listener.Prefixes.Add("http://*:7000/"); // Listen on port 80
            listener.Start();

            Console.WriteLine("Listening on port 7000...");

            while (true)
            {
                var context = listener.GetContext();
                var response = context.Response;

                // Respond to the incoming request
                string responseString = "Hello, World!";
                byte[] buffer = System.Text.Encoding.UTF8.GetBytes(responseString);

                response.ContentType = "text/html";
                response.ContentLength64 = buffer.Length;

                var output = response.OutputStream;
                output.Write(buffer, 0, buffer.Length);
                output.Close();
            }
        }
    }
}
