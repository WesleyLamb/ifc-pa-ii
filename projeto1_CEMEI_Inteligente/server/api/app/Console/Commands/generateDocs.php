<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use OpenApi\Generator;

class generateDocs extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'generate:docs';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Gerar Swagger da aplicação';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $rootPath = __DIR__.'/../../../';
        $openApi = new Generator();
        $openApi->generate([
            __FILE__,
            $rootPath.'app/Http/Controllers/V1/',
            $rootPath.'app/Http/Requests/V1/',
            $rootPath.'app/Http/Resources/V1/',
        ])->saveAs(storage_path('swagger/openapi_v1.json'));

        return Command::SUCCESS;
    }
}
