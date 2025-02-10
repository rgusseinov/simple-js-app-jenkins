<?php

declare(strict_types=1);

use Phinx\Migration\AbstractMigration;

final class AddValuesToUsersPositions extends AbstractMigration
{
    public function up(): void
    {
        // Update existing users where position is NULL
        $this->execute("UPDATE users SET position = 'Employee' WHERE position IS NULL");
    }

    public function down(): void
    {
        // Revert changes by resetting position to NULL (if needed)
        $this->execute("UPDATE users SET position = NULL WHERE position = 'Employee'");
    }
}
