<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>401 Unauthorized Access</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
        }
        .error-container {
            text-align: center;
            max-width: 600px;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .error-code {
            font-size: 5rem;
            font-weight: bold;
            color: #dc3545;
        }
        .error-title {
            font-size: 1.75rem;
            margin-bottom: 20px;
            color: #343a40;
        }
        .error-message {
            font-size: 1.1rem;
            color: #6c757d;
            margin-bottom: 30px;
        }
        .btn-home {
            background-color: #007bff;
            border: none;
            padding: 10px 30px;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }
        .btn-home:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">401</div>
        <h1 class="error-title">Unauthorized Access</h1>
        <p class="error-message">
            Sorry, you don't have permission to access this page. Please log in with the correct credentials or contact the administrator.
        </p>
        <a href="/RiceWareHouse2/home" class="btn btn-home text-white">Return to Homepage</a>
    </div>

    <!-- Bootstrap JS (Optional, only if you need Bootstrap JS features) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>